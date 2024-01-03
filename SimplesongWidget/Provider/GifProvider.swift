//
//  GifProvider.swift
//  Simplesong
//
//  Created by Adam Jassak on 09/08/2023.
//

import SwiftUI
import WidgetKit

/// GifProvider used as Widget Provider for GIF Widgets
struct GifProvider: TimelineProvider {
    func placeholder(in context: Context) -> GifEntry {
        GifEntry(date: Date(), frame: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (GifEntry) -> Void) {
        let entry = GifEntry(date: Date(), frame: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<GifEntry>) -> Void) {
        var entries = [GifEntry]()
        for i in 0..<60 {
            let updateDate = Calendar.current.date(byAdding: .second, value: i, to: Date())!
            let entry = GifEntry(date: updateDate, frame: i)
            entries.append(entry)
        }
        let timeLine = Timeline(entries: entries, policy: .atEnd)
        completion(timeLine)
    }
}

struct GifEntry: TimelineEntry {
    let date: Date
    let frame: Int
}

