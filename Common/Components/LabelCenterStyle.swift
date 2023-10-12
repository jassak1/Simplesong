//
//  LabelCenterStyle.swift
//  Simplesong
//
//  Created by Adam Jassak on 04/08/2023.
//

import SwiftUI

/// Custom Label Style centering the icon with multiline title
struct LabelCenterStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.icon
            configuration.title
        }
    }
}
