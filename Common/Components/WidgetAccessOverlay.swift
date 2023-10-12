//
//  WidgetAccessOverlay.swift
//  Simplesong
//
//  Created by Adam Jassak on 06/08/2023.
//

import SwiftUI

/// Custom SwiftUI View providing Widget Access denied overlay message
struct WidgetAccessOverlay: View {
    var fontSize: Font = .title
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            monoText(L10n.accessOverlay)
                .font(fontSize)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    WidgetAccessOverlay()
}
