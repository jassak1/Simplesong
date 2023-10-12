//
//  RadioMdRetroWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 04/09/2023.
//

import SwiftUI
import WidgetKit

struct RadioMdRetroView: View {
    let entry: RadioEntry
    var vm: WidgetSharedVM
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Asset.radioLogo.swiftUIImage
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/3.5)
                        .foregroundStyle(vm.radioRetroMdWorkshop.personalAppearance ? vm.radioRetroMdWorkshop.fgColor : .black)
                    Asset.radioSpeaker.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }                        .frame(maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment: .topLeading)
                Asset.radioDial.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay (
                        Text("\(entry.radioInfo.station)")
                            .foregroundStyle(Asset.radioDialColor.swiftUIColor)
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity,
                                   alignment: .bottomLeading)
                            .padding(.leading,
                                     geo.size.width/5.5)
                            .font(.caption)
                    )
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 5)
                            .foregroundStyle(Asset.darkRed.swiftUIColor)
                            .offset(x: entry.radioInfo.stationOffset)
                    )
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .bottomLeading)
                VStack {
                    Button(intent: RadioIntent(radioAction: entry.radioInfo.isPlaying ? .pause : .play)) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                            Circle()
                                .padding(3)
                                .foregroundStyle(vm.radioRetroMdWorkshop.personalAppearance ? vm.radioRetroMdWorkshop.detailColor : .brown.opacity(0.3))
                            Image(systemName: entry.radioInfo.isPlaying ?
                                  AppConstant.pauseIcon :
                                    AppConstant.playIcon)
                            .imageScale(.large)
                        }
                    }.buttonStyle(.plain)
                    Spacer()
                    Button(intent: RadioIntent(radioAction: .forward)) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                            Circle()
                                .padding(3)
                                .foregroundStyle(vm.radioRetroMdWorkshop.personalAppearance ? vm.radioRetroMdWorkshop.detailColor : .brown.opacity(0.3))
                            NextButtonLabel()
                        }
                    }.buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .trailing)
                OptionallyHidden(isHidden: entry.previewOnly ||
                                    !vm.showRadioSetupOverlay) {
                    RadioWidgetOverlay()
                }.foregroundStyle(.white)
            }
            .foregroundStyle(vm.radioRetroMdWorkshop.personalAppearance ? vm.radioRetroMdWorkshop.fgColor : .black)
        }.containerBackground(for: .widget) {
            getBg()
        }
        .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        ZStack {
            Color.black
            if vm.radioRetroMdWorkshop.personalAppearance {
                vm.radioRetroMdWorkshop.bgColor.opacity(0.3)
                ContainerRelativeShape()
                    .padding(5)
                    .foregroundStyle(
                        vm.radioRetroMdWorkshop.bgColor
                    )
            } else {
                Asset.radioFg.swiftUIColor.opacity(0.3)
                ContainerRelativeShape()
                    .padding(5)
                    .foregroundStyle(
                        Asset.radioFg.swiftUIColor
                    )
            }
        }
    }

    init(entry: RadioEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// Retro Radio medium Widget
struct RadioMdRetroWidget: Widget {
    let kind: String = WidgetKind.radioRetroMd.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: RadioProvider()) { entry in
            RadioMdRetroView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.radioRetroMd.rawValue)
                            .description(L10n.radioModernDesc)
    }
}


#Preview(as: .systemMedium) {
    RadioMdRetroWidget()
} timeline: {
    RadioEntry(date: Date(), radioInfo: .init(), previewOnly: true)
}
