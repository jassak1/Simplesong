//
//  SimpleIntent.swift
//  SimplesongWidgetExtension
//
//  Created by Adam Jassak on 16/07/2023.
//

import AppIntents
import MusicKit
import UIKit

/// AppIntent used for Interactive Widget player
struct SimpleIntent: AppIntent {
    static var title: LocalizedStringResource = "SimpleSong Widget Player Intent"

    @Parameter(title: "PlayerAction")
    var playerAction: PlayerAction

    func perform() async throws -> some IntentResult {
        switch playerAction {
        case .play:
            try await DI.shared.simpleIntentVm.playSong()
        case .pause:
            DI.shared.simpleIntentVm.pauseSong()
        case .forward:
            try await DI.shared.simpleIntentVm.nextSong()
        case .backward:
            try await DI.shared.simpleIntentVm.prevSong()
        case .restart:
            DI.shared.simpleIntentVm.restartSong()
        case .shuffle:
            DI.shared.simpleIntentVm.shuffleLibrary()

        }
        return .result()
    }

    init(playerAction: PlayerAction) {
        self.playerAction = playerAction
    }

    init() {
        playerAction = .play
    }
}

/// ViewModel for SimpleIntent
struct SimpleIntentVM {
    /// MusicService property
    let musicService: MusicServiceProto

    /// Method responsible for playing song
    func playSong() async throws {
        guard let _ = SystemMusicPlayer.shared.queue.currentEntry else {
            try await musicService.prepareSystemMusicQueue()
            try await SystemMusicPlayer.shared.play()
            return
        }
        try await SystemMusicPlayer.shared.play()
    }

    /// Method responsible for pausing song
    func pauseSong() {
        SystemMusicPlayer.shared.pause()
    }

    /// Method responsible for skipping to next song
    func nextSong() async throws {
        try await SystemMusicPlayer.shared.skipToNextEntry()
    }

    /// Method responsible for skipping to previous song
    func prevSong() async throws {
        try await SystemMusicPlayer.shared.skipToPreviousEntry()
    }

    /// Method responsible for restarting current song
    func restartSong() {
        SystemMusicPlayer.shared.restartCurrentEntry()
    }

    /// Method responsible for shuffling song library
    func shuffleLibrary() {
        SystemMusicPlayer.shared.state.shuffleMode = .songs
    }

    // MARK: - Initialiser
    init(musicService: MusicServiceProto) {
        self.musicService = musicService
    }
}
