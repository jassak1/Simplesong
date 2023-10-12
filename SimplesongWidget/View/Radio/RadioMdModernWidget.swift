//
//  RadioMdModernWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 01/09/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVKit

struct RadioMdModernView: View {
    let entry: RadioEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            VStack {
                monoText(entry.radioInfo.station)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                HStack(spacing: 30) {
                    Button(intent: RadioIntent(radioAction: .backward),
                           label: {
                        PrevButtonLabel()
                    }).buttonStyle(.plain)
                    Button(intent: RadioIntent(radioAction: entry.radioInfo.isPlaying ? .pause : .play),
                           label: {
                        Image(systemName: entry.radioInfo.isPlaying ? AppConstant.pauseIcon : AppConstant.playIcon)
                            .font(.largeTitle)
                    }).buttonStyle(.plain)
                    Button(intent: RadioIntent(radioAction: .forward),
                           label: {
                        NextButtonLabel()
                    }).buttonStyle(.plain)
                }.scaleEffect(vm.radioModernMdWorkshop.personalAppearance ? vm.radioModernMdWorkshop.size : 1)
            }
            OptionallyHidden(isHidden:
                                entry.previewOnly ||
                                !vm.showRadioSetupOverlay) {
                RadioWidgetOverlay()
            }
        }.foregroundStyle(vm.radioModernMdWorkshop.personalAppearance ? vm.radioModernMdWorkshop.fgColor : .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.radioModernMdWorkshop.personalAppearance,
           vm.radioModernMdWorkshop.transparentBg {
            Image(uiImage: vm.radioModernMdWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.radioModernMdWorkshop.personalAppearance {
            vm.radioModernMdWorkshop.bgColor
        } else {
            Color.black
        }
    }

    init(entry: RadioEntry) {
        vm = DI.shared.widgetSharedVm
        self.entry = entry
    }
}

/// Modern Radio medium Widget
struct RadioMdModernWidget: Widget {
    let kind: String = WidgetKind.radioModernMd.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: RadioProvider()) { entry in
            RadioMdModernView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.radioModernMd.rawValue)
                            .description(L10n.radioModernDesc)
    }
}

#Preview(as: .systemMedium) {
    RadioMdModernWidget()
} timeline: {
    RadioEntry(date: Date(), radioInfo: .init(), previewOnly: true)
}
