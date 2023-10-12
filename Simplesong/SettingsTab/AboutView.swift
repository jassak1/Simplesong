//
//  AboutView.swift
//  Simplesong
//
//  Created by Adam Jassak on 04/08/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            VStack {
                monoText(L10n.aboutApp)
            }.padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }.navigationTitle(L10n.about)
            .dynamicTypeSize(.medium)
    }
}

#Preview {
    AboutView()
}
