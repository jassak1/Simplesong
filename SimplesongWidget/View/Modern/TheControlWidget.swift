//
//  TheControlWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 27/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct TheControlView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            HStack(spacing: 30) {
                Button(intent: SimpleIntent(playerAction: .backward),
                       label: {
                    PrevButtonLabel()
                }).buttonStyle(.plain)
                Button(intent: SimpleIntent(
                    playerAction: entry.songInfo.isPlaying ? .pause : .play),
                       label: {
                    Image(systemName: entry.songInfo.isPlaying ? AppConstant.pauseIcon : AppConstant.playIcon)
                        .font(.largeTitle)
                }).buttonStyle(.plain)
                Button(intent: SimpleIntent(playerAction: .forward),
                       label: {
                    NextButtonLabel()
                }).buttonStyle(.plain)
            }.scaleEffect(vm.theControlWorkshop.personalAppearance ? vm.theControlWorkshop.size : 1)
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }.foregroundStyle(vm.theControlWorkshop.personalAppearance ? vm.theControlWorkshop.fgColor : .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.theControlWorkshop.personalAppearance,
           vm.theControlWorkshop.transparentBg {
            Image(uiImage: vm.theControlWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.theControlWorkshop.personalAppearance {
            vm.theControlWorkshop.bgColor
        } else {
            Color.black
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// The Control Widget
struct TheControlWidget: Widget {
    let kind: String = WidgetKind.theControl.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            TheControlView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.theControl.rawValue)
                            .description(L10n.theControlDesc)
    }
}

#Preview(as: .systemMedium) {
    TheControlWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
