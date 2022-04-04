//
//  EmojiArtDocumentView.swift
//  EmojiArtAssignment5
//
//  The View
//  Created by Dallen Corry on 3/28/22.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                //background
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in: geometry.size))
                .onTapGesture {
                    document.deselectAllEmojis()
                }
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    //emojis
                    ForEach(document.emojis) { emoji in
                        if(document.isSelected(emoji)) {
                            ZStack {
                                Text(emoji.text)
                                    .font(.system(size: fontSize(for: emoji)))
                                    .scaleEffect(zoomScale*emojiZoomScale)
                                    .position(position(for: emoji, in: geometry))
                                    .overlay(RoundedRectangle(cornerRadius: 5)
                                                .stroke(.blue, lineWidth: 3)
                                                .frame(width:(CGFloat(emoji.size)*zoomScale*emojiZoomScale), height: (CGFloat(emoji.size)*zoomScale*emojiZoomScale), alignment: .top)
                                                .position(position(for: emoji, in: geometry)))
                            }
                            .onTapGesture {
                                document.selectEmoji(emoji)
                            }
                            .gesture(dragEmojiGesture(emoji: emoji))
                        } else {
                            Text(emoji.text)
                                .font(.system(size: fontSize(for: emoji)))
                                .scaleEffect(zoomScale)
                                .position(position(for: emoji, in: geometry))
                                .onTapGesture {
                                    document.selectEmoji(emoji)
                                }
                        }
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(panGesture().simultaneously(with: zoomGesture()))
        }
    }
    
    
    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Positioning/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        if(document.isSelected(emoji)) {
                return convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry) + dragOffset/zoomScale
        } else {
                return convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
         }
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    // MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    //on a pinch gesture, it will zoom emojis if there are any selected
    private var zoomScale: CGFloat {
        if(!document.selectedEmojis.isEmpty){
            return steadyStateZoomScale
        } else {
            return steadyStateZoomScale * gestureZoomScale
        }
    }
    
    private var emojiZoomScale: CGFloat {
        if(!document.selectedEmojis.isEmpty) {
            return gestureZoomScale
        } else {
            return 1
        }
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                    gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                if document.selectedEmojis.isEmpty {
                    steadyStateZoomScale *= gestureScaleAtEnd
                } else {
                    document.scaleSelectedEmojis(by: gestureScaleAtEnd)
                }
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    // MARK: - Panning
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }
    
    // MARK: - Dragging Emojis
    
    @GestureState private var gestureDragOffset: CGSize = CGSize.zero
    
    private var dragOffset: CGSize {
        gestureDragOffset * zoomScale
    }
    
    private func dragEmojiGesture(emoji:EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
            .updating($gestureDragOffset) { latestDragGestureValue, gestureDragOffset, _ in
                gestureDragOffset = latestDragGestureValue.translation
            }
            .onEnded { finalDragGestureValue in
                document.moveSelectedEmojis(by: finalDragGestureValue.translation/zoomScale)
            }
    }

    // MARK: - Palette
    @State var scale:CGFloat = 1
    var palette: some View {
        HStack {
            ScrollingEmojisView(emojis: testEmojis)
                .font(.system(size: defaultEmojiFontSize))
            if(!document.selectedEmojis.isEmpty) {
                trashCan
                    .foregroundColor(.red)
                    .onTapGesture {
                        document.removeSelectedEmojis()
                    }
            } else {
                trashCan
                    .opacity(0.01)
            }
        }
    }
    
    var trashCan: some View {
        Image(systemName: "trash")
            .font(.largeTitle)
    }
    
    let testEmojis = "😀😁😂😇😡🤢😈☠️👍👌🚶‍♂️🚶‍♀️🏃‍♂️🏃‍♀️🎃👻👀🐶🌲🌴🌳🗿🌎🌙🌞🌝🔥💣🧨☄️🍎⚽️🚗🚓🚲🛩🚁🚀🛸🏠⌚️🎁🗝🔐❤️⛔️❌❓✅⚠️🎶➕➖🚩🏳️🇺🇸🇪🇸🇲🇽🇯🇲🇯🇵🇩🇪🇨🇳"
}

struct ScrollingEmojisView: View {
    let emojis: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}

// TODO: -
        // [X] 1. Don't break anything
        // [X] 2. Be able to select multiple emojis in the document
        // [X] 3. Tapping an unselected emoji shouild select it
        // [X] 4. Tapping on a selected emoji should deselect it.
        // [X] 5. single tapping on the background of the document should deselect All emojis
        // [X] 6. Dragging a selected emoji should make all selected emojis follow the users finger.
        //need to make the moveSelcted work, because the selected ones will follow your finger, but not update their coordinates on end
        // [X] 7. If no emojis selected, drag the entire document (already working, just add the if somehow)  **Don't Break**
        // [X] 8. scale emojis on pinch (if emojis are selected)
        // [X] 9. Scale document on pinch (If no emojis selected)  **Don't Break**
        // [X] 10. delete emojis somehow

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}

