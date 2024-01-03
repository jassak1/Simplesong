//
//  FAQView.swift
//  Simplesong
//
//  Created by Adam Jassak on 04/08/2023.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(1..<15) { item in
                        VStack(alignment: .leading) {
                            Text("\(item). \(NSLocalizedString("q\(item)", comment: ""))")
                            Text("\(NSLocalizedString("a\(item)", comment: ""))")
                                .foregroundStyle(.gray)
                        }
                    }.listRowBackground(Color.black)
                }.listStyle(.grouped)
            }
        }.navigationTitle(L10n.faq)
            .dynamicTypeSize(.medium)
    }
}

#Preview {
    FAQView()
}
