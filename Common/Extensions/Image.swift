//
//  Image.swift
//  Simplesong
//
//  Created by Adam Jassak on 15/07/2023.
//

import SwiftUI

extension Image {
    /// Custom Image viewModifier applying border for an Image
    func widgetBorder(for widget: WidgetKind) -> some View {
        var frameSize: CGFloat {
            if WidgetKind.smallWidgets.contains(widget) {
                return 150
            } else {
                return 250
            }
        }
        return self
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
            }
            .padding()
            .frame(width: frameSize)
    }
}
