//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Dallen Corry on 3/11/22.
//
//  to pinch on simulator, hold down option key.

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
        GeometryReader {geometry in
            ZStack {
                Color.blue//temp background
                ForEach(document.emojis) { emoji in
                    Text(emoji.text)
                        .font(.system(size: fontSize(for:emoji)))
                        .position(position(for: emoji, in: geometry))
                }
            }
            .onDrop(of: [.plainText], isTargeted: nil) {providers, location in
                return drop(providers:providers, at: location, in: geometry)
            }
        }
    }
    
    //palette of emojis below the screen
    var palette: some View {
        ScrollingEmojisView(emojis: testEmojis)
        .font(.system(size:defaultEmojiFontSize))
    }
    
    
    //what to do when an emoji is dropped onto the background
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool{
        return providers.loadObjects(ofType:String.self) { string in //function from extension
            if let emoji = string.first, emoji.isEmoji {//also provided in extensions
                document.addEmoji(
                    String(emoji),
                    at: convertToEmojiCoordinates(location, in: geometry),
                    size: defaultEmojiFontSize
                )
            }
        }
    }
    
    //because reasons?
    private func position(for emoji:EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x,emoji.y), in: geometry)
    }
    
    //convert from EmojiArt coordinates to View Coordinates
    private func convertFromEmojiCoordinates (_ location:(x:Int, y:Int), in geometry: GeometryProxy) -> CGPoint {//geometry proxy is the thing we get from geometry reader
        let center = geometry.frame(in: .local).center //center of our frame, added in the utilityExensions.swift
        return CGPoint (
            x:center.x+CGFloat(location.x),
            y:center.y+CGFloat(location.y)
        )
    }
    
    //convert View coordinates to Emoji Coordinates
    private func convertToEmojiCoordinates (_ location:CGPoint, in geometry: GeometryProxy) -> (x:Int, y:Int) {//geometry proxy is the thing we get from geometry reader
        let center = geometry.frame(in: .local).center //center of our frame, added in the utilityExensions.swift
        let location = CGPoint(
            x:location.x - center.x,
            y:location.y - center.y
        )
        return (Int(location.x),Int(location.y))
    }

    //calculates the font size for a specific emoji
    private func fontSize(for emoji:EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)//need to change this with a pinch in HW
    }
    
    
    
    
    
    
    
    
    
    
    let testEmojis = "😀😃😄🥵😡🥶😨🤢🤮👹👺😈👿👾💀☠️"
}


struct ScrollingEmojisView: View {
    let emojis:String

    var body:some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0)}, id: \.self) {//this takes eah emoji and "maps" it to whatever. In this case a string. So this will take our Sring testEmojis into an array of emojis. easy! .... yeah...
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
