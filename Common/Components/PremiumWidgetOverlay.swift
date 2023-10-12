//
//  PremiumWidgetOverlay.swift
//  Simplesong
//
//  Created by Adam Jassak on 19/08/2023.
//

import SwiftUI

struct PremiumWidgetOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            monoText(L10n.premiumOverlay)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    PremiumWidgetOverlay()
}
