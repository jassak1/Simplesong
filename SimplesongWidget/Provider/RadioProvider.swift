//
//  RadioProvider.swift
//  Simplesong
//
//  Created by Adam Jassak on 02/09/2023.
//

import WidgetKit
import AVFoundation
import MusicKit

/// RadioProvider used as Widget Provider for Radio Widgets
struct RadioProvider: TimelineProvider {
    func placeholder(in context: Context) -> RadioEntry {
        RadioEntry(date: Date(), radioInfo: .init(), previewOnly: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (RadioEntry) -> ()) {
        let entry = RadioEntry(date: Date(), radioInfo: .init(), previewOnly: true)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RadioEntry>) -> ()) {
        let entry = RadioEntry(date: Date(), radioInfo: getRadioDetails(), previewOnly: false)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    // MARK: - Helper methods
    /// Private method responsible for retrieving `RadioInfo`
    private func getRadioDetails() -> RadioInfo {
        let isPlaying = UserDefaults.getValue(for: .isPlaying, defaultValue: false)
        let currentSelection = UserDefaults.getValue(for: .currentStation, defaultValue: 0)
        let baseStation: RadioStations? = UserDefaults.getData(for: .primaryStationInfo)
        var currentStation: RadioStations?
        var stationOffset: CGFloat = -50

        switch currentSelection {
        case 0:
            currentStation = baseStation
            stationOffset = -50
        case 1:
            currentStation = UserDefaults.getData(for: .secondaryStationInfo)
            stationOffset = 0
        default:
            currentStation = UserDefaults.getData(for: .thirdStationInfo)
            stationOffset = 50
        }
        return RadioInfo(station: currentStation?.name ?? baseStation?.name ?? "",
                         isPlaying: isPlaying,
                         stationOffset: stationOffset)
    }
}

/// RadioEntry for Radio Widgets
struct RadioEntry: TimelineEntry {
    let date: Date
    let radioInfo: RadioInfo
    let previewOnly: Bool
}
