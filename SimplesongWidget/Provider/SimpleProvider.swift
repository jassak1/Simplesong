//
//  SimpleProvider.swift
//  SimplesongWidgetExtension
//
//  Created by Adam Jassak on 16/07/2023.
//

import WidgetKit
import MusicKit
import UIKit

/// SimpleProvider used as Widget Provider for Player Widgets
struct SimpleProvider: TimelineProvider {
    let viewModel: SimpleProviderVM

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), songInfo: SongInfo(), premiumUnlocked: true, previewOnly: true)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), songInfo: SongInfo(), premiumUnlocked: true, previewOnly: true)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        Task {
            let currentDate = Date()
            let nextUpdateDate = Calendar.current.date(byAdding: .second, value: 60, to: currentDate)!

            let songInfo = await viewModel.getSongInfo()
            let entry = SimpleEntry(date: Date(), songInfo: songInfo, previewOnly: false)
            let followUpEntry = SimpleEntry(date: nextUpdateDate, songInfo: songInfo, previewOnly: false)

            let timeLine = Timeline(entries: [entry, followUpEntry], policy: .atEnd)
            completion(timeLine)
        }
    }

    init() {
        viewModel = DI.shared.simpleProviderVm
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let songInfo: SongInfo
    var premiumUnlocked: Bool = UserDefaults.getValue(for: .premiumUnlocked, defaultValue: false)
    let previewOnly: Bool
}
