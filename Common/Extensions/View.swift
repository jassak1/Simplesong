//
//  View.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

/// SwiftUI View extension
extension View {
    /// Returns SwiftUI Text View with monospaced fontDesign
    func monoText(_ string: String) -> Text {
        Text(string)
            .fontDesign(.monospaced)
    }
}
