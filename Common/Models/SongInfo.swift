//
//  SongInfo.swift
//  Simplesong
//
//  Created by Adam Jassak on 21/07/2023.
//

import SwiftUI

/// Custom type holding Song informations
struct SongInfo {
    let currentSongTitle: String
    let currentSongAuthor: String
    let currentSongImage: UIImage
    let currentSongColor: Color
    let isPlaying: Bool
    let prevSongImage: UIImage
    let nextSongImage: UIImage

    init(currentSongTitle: String,
         currentSongAuthor: String,
         currentSongImage: UIImage,
         currentSongColor: Color,
         isPlaying: Bool,
         prevSongImage: UIImage,
         nextSongImage: UIImage) {
        self.currentSongTitle = currentSongTitle
        self.currentSongAuthor = currentSongAuthor
        self.currentSongImage = currentSongImage
        self.currentSongColor = currentSongColor
        self.isPlaying = isPlaying
        self.prevSongImage = prevSongImage
        self.nextSongImage = nextSongImage
    }

    init() {
        currentSongTitle = "Song Author"
        currentSongAuthor = "Title of the Song"
        currentSongImage = UIImage(asset: Asset.artwork) ?? UIImage()
        currentSongColor = .black
        isPlaying = false
        prevSongImage = UIImage(asset: Asset.artwork) ?? UIImage()
        nextSongImage = UIImage(asset: Asset.artwork) ?? UIImage()
    }
}
