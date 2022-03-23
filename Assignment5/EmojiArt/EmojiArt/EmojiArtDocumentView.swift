//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Dallen Corry on 3/11/22.
//
//  to 

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize:CGFloat = 40
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    //the main Art section
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                //background
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)//OptionalImage is in utility
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in:geometry.size))
                //emojis
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(.system(size: fontSize(for:emoji)))
                            .scaleEffect(zoomScale)
                            .position(position(for: emoji, in: geometry))
                    }
                
                }
            }
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                return drop(providers:providers, at: location, in: geometry)
            }
            .gesture(panGesture().simultaneously(with: zoomGesture()))
        }
    }
    
    //what to do when an emoji is dropped onto the background
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(EmojiArtModel.Background.url(url.imageURL))
            //uses extension ".imagerURL" so that we can get the image instead of the link on google
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        
        if !found {
            found =  providers.loadObjects(ofType:String.self) { string in //function from extension
                if let emoji = string.first, emoji.isEmoji {//also provided in extensions
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
    
    //because reasons for homework?
    private func position(for emoji:EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x,emoji.y), in: geometry)
    }
    
    //convert from EmojiArt coordinates to View Coordinates
    private func convertFromEmojiCoordinates (_ location:(x:Int, y:Int), in geometry: GeometryProxy) -> CGPoint {//geometry proxy is the thing we get from geometry reader
        let center = geometry.frame(in: .local).center //center of our frame, added in the utilityExensions.swift
        return CGPoint (
            x:center.x+CGFloat(location.x)*zoomScale + panOffSet.width,
            y:center.y+CGFloat(location.y)*zoomScale + panOffSet.height
        )
    }
    
    //convert View coordinates to Emoji Coordinates
    private func convertToEmojiCoordinates (_ location:CGPoint, in geometry: GeometryProxy) -> (x:Int, y:Int) {//geometry proxy is the thing we get from geometry reader
        let center = geometry.frame(in: .local).center //center of our frame, added in the utilityExensions.swift
        let location = CGPoint(
            x:(location.x - panOffSet.width - center.x)/zoomScale,
            y:(location.y - panOffSet.height - center.y)/zoomScale
        )
        return (Int(location.x),Int(location.y))
    }

    //calculates the font size for a specific emoji
    private func fontSize(for emoji:EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)//need to change this with a pinch in HW
    }
    
    
    //dragging
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset:CGSize = CGSize.zero
    private var panOffSet: CGSize {
        (steadyStatePanOffset + gesturePanOffset)*zoomScale//adding is ANOTHER of his extensions.
        //move more when zoomed in
    }
    //drag gesture
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset+(finalDragGestureValue.translation / zoomScale)
            }
    }
    
    
    //zooming
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale:CGFloat = 1
    private var zoomScale:CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomToFit(_ image:UIImage?, in size: CGSize) {
        if let image = image, image.size.width>0, image.size.height>0, size.width>0, size.width>0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStateZoomScale = min(hZoom,vZoom)
            steadyStatePanOffset = .zero
        }
    }
    
    //zoom gestures
    private func doubleTapToZoom(in size:CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale//whatever pich is doing, that is our scale.
                //this stupid thing is a load of crap. We don't actually use it irl
            }
            .onEnded { gestureScaleAtEnd in
                steadyStateZoomScale *= gestureScaleAtEnd
            }
    }

    
    //palette of emojis below the screen
    let testEmojis = "😀😃😄🥵😡🥶😨🤢🤮👹👺😈👿👾💀☠️"
    var palette: some View {
            ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size:defaultEmojiFontSize))
    }
}

//custom View
struct ScrollingEmojisView: View {
    let emojis:String

    var body:some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0)}, id: \.self) {//this takes each emoji and "maps" it to whatever. In this case a string. So this will take our Sring testEmojis into an array of emojis. easy! .... yeah... right.
                    emoji in
                    Text(emoji)
                        .onDrag {
                            NSItemProvider(object: emoji as NSString)//provide this data as the Objective c object. Doesn't block the main API of the app
                        }
                }
            }
        }
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
