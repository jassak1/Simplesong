//
//  SimpleIntent.swift
//  SimplesongWidgetExtension
//
//  Created by Adam Jassak on 16/07/2023.
//

import AppIntents

/// AppIntent used for Interactive Widget GIF
struct GifIntent: AppIntent {
    static var title: LocalizedStringResource = "Gif Widget Intent"

    func perform() async throws -> some IntentResult {
        return .result()
    }
}
