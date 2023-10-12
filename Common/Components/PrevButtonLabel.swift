//
//  PrevButtonLabel.swift
//  Simplesong
//
//  Created by Adam Jassak on 22/07/2023.
//

import SwiftUI

/// Custom SwiftUI View for Previous button label
struct PrevButtonLabel: View {
    var body: some View {
        HStack(spacing: -4) {
            ForEach(0..<2) { _ in
                Image(systemName: AppConstant.prevIcon)
            }
        }
    }
}

#Preview {
    PrevButtonLabel()
}
