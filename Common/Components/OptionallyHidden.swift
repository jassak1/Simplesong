//
//  OptionallyHidden.swift
//  Simplesong
//
//  Created by Adam Jassak on 15/07/2023.
//

import SwiftUI

/// Custom SwiftUI View displaying underlying content conditionally
struct OptionallyHidden<T: View>: View {
    var isHidden: Bool
    @ViewBuilder var content: T
    var body: some View {
        if !isHidden {
            content
        }
    }
}
