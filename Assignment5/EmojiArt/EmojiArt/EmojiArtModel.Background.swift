//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Dallen Corry on 3/11/22.
//


import Foundation

extension EmojiArtModel {
    enum Background: Equatable {
        case blank
        case url (URL)
        case imageData (Data)//Data is basically just a byte buffer
        
        //convenience function to get the url
        var url:URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
    }
}
