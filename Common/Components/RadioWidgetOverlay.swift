//
//  RadioWidgetOverlay.swift
//  Simplesong
//
//  Created by Adam Jassak on 09/09/2023.
//

import SwiftUI

struct RadioWidgetOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            monoText(L10n.radioOverlay)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    RadioWidgetOverlay()
}
