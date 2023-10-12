//
//  TheButtonWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 27/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct TheButtonView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            Button(intent: SimpleIntent(playerAction: entry.songInfo.isPlaying ? .pause : .play),
                   label: {
                Image(systemName: entry.songInfo.isPlaying ? AppConstant.pauseIcon : AppConstant.playIcon)
                    .resizable()
                    .scaledToFill()
                    .padding(20)
                    .scaleEffect(vm.theButtonWorkshop.personalAppearance ?
                                 vm.theButtonWorkshop.size : 1.0)
            }
            ).buttonStyle(.plain)
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay(fontSize: .callout)
            }
        }.foregroundStyle(vm.theButtonWorkshop.personalAppearance ?
                          vm.theButtonWorkshop.fgColor :
                .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.theButtonWorkshop.personalAppearance,
           vm.theButtonWorkshop.transparentBg {
            Image(uiImage: vm.theButtonWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.theButtonWorkshop.personalAppearance {
            vm.theButtonWorkshop.bgColor
        } else {
            Color.black
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// The Button Widget
struct TheButtonWidget: Widget {
    let kind: String = WidgetKind.theButton.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            TheButtonView(entry: entry)
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.theButton.rawValue)
                            .description(L10n.theButtonDesc)
    }
}

#Preview(as: .systemSmall) {
    TheButtonWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
