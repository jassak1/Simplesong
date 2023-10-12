//
//  VisualizerSmWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/08/2023.
//

import SwiftUI
import WidgetKit

struct VisualizerMdView: View {
    let entry: GifEntry
    let vm: WidgetSharedVM
    var body: some View {
        ZStack {
            Button(intent: GifIntent(), label: {
                Image("\(vm.visualizerMdWorkshop.visualization)\(entry.frame)")
                    .resizable()
                    .scaledToFit()
            }).buttonStyle(.plain)
            OptionallyHidden(isHidden: entry.premiumUnlocked) {
                PremiumWidgetOverlay()
            }
        }
        .foregroundStyle(.white)
        .containerBackground(for: .widget) {
            getBg()
        }
        .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.visualizerMdWorkshop.personalAppearance,
           vm.visualizerMdWorkshop.transparentBg {
            Image(uiImage: vm.visualizerMdWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.visualizerMdWorkshop.personalAppearance {
            vm.visualizerMdWorkshop.bgColor
        } else {
            Color.black
        }
    }


    init(entry: GifEntry) {
        self.entry = entry
        self.vm = DI.shared.widgetSharedVm
    }
}

/// Shuffle Widget
struct VisualizerMdWidget: Widget {
    let kind: String = WidgetKind.visualizerMd.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: GifProvider()) { entry in
            VisualizerMdView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.visualizerMd.rawValue)
                            .description(L10n.visualizerMdDesc)
    }
}

#Preview(as: .systemMedium) {
    VisualizerMdWidget()
} timeline: {
    GifEntry(date: Date(), frame: 0)
}
