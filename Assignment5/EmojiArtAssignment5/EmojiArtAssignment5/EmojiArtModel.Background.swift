//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Background object
//  Created by Dallen Corry on 3/28/22.
//

import Foundation

extension EmojiArtModel {
    enum Background: Equatable {
        case blank
        case url(URL)
        case imageData(Data)
        
        var url: URL? {
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
