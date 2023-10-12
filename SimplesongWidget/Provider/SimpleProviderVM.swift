//
//  SimpleProviderVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 21/07/2023.
//

import SwiftUI
import MusicKit

struct SimpleProviderVM {
    /// MusicService property
    let musicService: MusicServiceProto

    /// Method responsible for preparing SongInfo type based on currently played Song
    func getSongInfo() async -> SongInfo {
        do {
            let allSongs = try await musicService.getLocalLibrarySongs(downloadedOnly: false).items
            let currentIndex = await musicService.getCurrentSongIndex(downloadedOnly: false)

            var currentTitle = allSongs[currentIndex].title
            var currentAuthor = allSongs[currentIndex].artistName
            var currentImage = UIImage(asset: Asset.artwork) ?? UIImage()
            var prevImage = UIImage(asset: Asset.artwork) ?? UIImage()
            var nextImage = UIImage(asset: Asset.artwork) ?? UIImage()
            if let url = allSongs[currentIndex].artwork?.url(width: 400, height: 400) {
                currentImage = await getImage(from: url)
            }
            if  currentIndex != 0,
                let url = allSongs[currentIndex-1].artwork?.url(width: 400, height: 400) {
                prevImage = await getImage(from: url)
            }
            if  currentIndex != 0,
                currentIndex != allSongs.indices.last,
                let url = allSongs[currentIndex+1].artwork?.url(width: 400, height: 400) {
                nextImage = await getImage(from: url)
            }
            var currenColor = Color(cgColor: allSongs[currentIndex].artwork?.backgroundColor ?? .defaultColor)
            
            if currentIndex == 0 {
                let currentSong = SystemMusicPlayer.shared.queue.currentEntry
                currentTitle = currentSong?.title ?? ""
                currentAuthor = getAuthor(from: currentSong?.description ?? "")
                currentImage = UIImage(asset: Asset.artwork) ?? UIImage()
                if let url = currentSong?.artwork?.url(width: 400, height: 400) {
                    currentImage = await getImage(from: url)
                }
                currenColor = Color(cgColor: currentSong?.artwork?.backgroundColor ?? .defaultColor)
            }

            return SongInfo(currentSongTitle: currentTitle,
                            currentSongAuthor: currentAuthor,
                            currentSongImage: currentImage,
                            currentSongColor: currenColor,
                            isPlaying: SystemMusicPlayer.shared.state.playbackStatus == .playing,
                            prevSongImage: prevImage,
                            nextSongImage: nextImage)
        } catch {
            return SongInfo()
        }
    }

    /// Helper method responsible for retrieving Image from provided URL
    /// When exception occurs, default Artwork asset UIImage is returned
    private func getImage(from url: URL) async -> UIImage {
        do {
            let resultData = try await URLSession.shared.data(from: url).0
            let image = UIImage(data: resultData) ?? UIImage()
            return image
        } catch {
            return UIImage(asset: Asset.artwork) ?? UIImage()
        }

    }

    /// Helper method responsible for retrieving Author of a Song from String description
    private func getAuthor(from string: String) -> String {
        let partialResult =  string.components(separatedBy: ",").last?.components(separatedBy: "\"")
        if let partialResult,
           partialResult.indices.contains(1) {
            return partialResult[1]
        } else {
            return ""
        }
    }

    // MARK: - Initialiser
    init(musicService: MusicServiceProto) {
        self.musicService = musicService
    }
}
