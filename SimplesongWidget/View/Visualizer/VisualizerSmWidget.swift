//
//  VisualizerSmWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/08/2023.
//

import SwiftUI
import WidgetKit

struct VisualizerSmView: View {
    let entry: GifEntry
    let vm: WidgetSharedVM
    var body: some View {
        ZStack {
            Button(intent: GifIntent(),
                   label: {
                Image("\(vm.visualizerSmWorkshop.visualization)\(entry.frame)")
                    .resizable()
                    .scaledToFit()
            }).buttonStyle(.plain)
        }
        .containerBackground(for: .widget) {
            getBg()
        }
        .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.visualizerSmWorkshop.personalAppearance,
           vm.visualizerSmWorkshop.transparentBg {
            Image(uiImage: vm.visualizerSmWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.visualizerSmWorkshop.personalAppearance {
            vm.visualizerSmWorkshop.bgColor
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
struct VisualizerSmWidget: Widget {
    let kind: String = WidgetKind.visualizerSm.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: GifProvider()) { entry in
            VisualizerSmView(entry: entry)
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.visualizerSm.rawValue)
                            .description(L10n.visualizerSmDesc)
    }
}

#Preview(as: .systemSmall) {
    VisualizerSmWidget()
} timeline: {
    GifEntry(date: Date(), frame: 0)
}
