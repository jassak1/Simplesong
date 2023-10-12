//
//  RadioIntent.swift
//  Simplesong
//
//  Created by Adam Jassak on 31/08/2023.
//

import Foundation
import AppIntents
import AVFoundation
import WidgetKit

/// AppIntent used for Radio Widget
struct RadioIntent: AudioPlaybackIntent {
    static var title: LocalizedStringResource = "Radio Widget Intent"
    static var description: IntentDescription = IntentDescription("Radio station playback")

    @Parameter(title: "PlayerAction")
    var radioAction: RadioAction

    func perform() async throws -> some IntentResult {
        switch radioAction {
        case .play:
            try DI.shared.radioIntentVm.playStation()
        case .pause:
            try DI.shared.radioIntentVm.stopPlayback()
        case .forward:
            try DI.shared.radioIntentVm.playNextStation()
        case .backward:
            try DI.shared.radioIntentVm.playPrevStation()
        }

        return .result()
    }

    init(radioAction: RadioAction) {
        self.radioAction = radioAction
    }

    init() {
    }
}

/// ViewModel for RadioIntent
class RadioIntentVM {
    var player = AVPlayer()

    /// Method responsible fro stopping a playback of radio station
    func stopPlayback() throws {
        try AVAudioSession.sharedInstance().setActive(false)
        UserDefaults.setValue(for: .isPlaying, setValue: false)
    }

    /// Method responsible for playing specific station conditionally
    func playStation() throws {
        let currentSelection = UserDefaults.getValue(for: .currentStation, defaultValue: 0)

        let mainStation: RadioStations? = UserDefaults.getData(for: .primaryStationInfo)

        switch currentSelection {
        case 0:
            try startPlayback(for: mainStation?.url ?? "")
        case 1:
            let station: RadioStations? = UserDefaults.getData(for: .secondaryStationInfo)
            try startPlayback(for: station?.url ?? mainStation?.url ?? "")
        default:
            let station: RadioStations? = UserDefaults.getData(for: .thirdStationInfo)
            try startPlayback(for: station?.url ?? mainStation?.url ?? "")
        }
    }

    /// Method responsible for skipping to forward station
    func playNextStation() throws {
        let currentSelection = UserDefaults.getValue(for: .currentStation, defaultValue: 0)
        UserDefaults.setValue(for: .currentStation, setValue: currentSelection == 2 ? 0 : currentSelection + 1)
        try playStation()
    }

    /// Method responsible for skipping to previous station
    func playPrevStation() throws {
        let currentSelection = UserDefaults.getValue(for: .currentStation, defaultValue: 0)
        UserDefaults.setValue(for: .currentStation, setValue: currentSelection == 0 ? 2 : currentSelection - 1)
        try playStation()
    }

    /// Method responsible for playing a specific station
    private func startPlayback(for station: String) throws {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try AVAudioSession.sharedInstance().setActive(true)
        let url = URL(string: station)
        guard let url else { return }

        let playerItem = AVPlayerItem(url: url)

        player = AVPlayer(playerItem: playerItem)
        player.play()
        let isPlaying = player.rate != 0
        UserDefaults.setValue(for: .isPlaying, setValue: isPlaying)
    }
}

