//
//  WorkshopView.swift
//  Simplesong
//
//  Created by Adam Jassak on 15/07/2023.
//

import SwiftUI

struct WorkshopView: View {
    @Bindable var viewModel: HomeVM
    @Bindable var widgetVm: WidgetSharedVM
    @State private var navPath = NavigationPath()
    var body: some View {
        // MARK: - Workshop View
        NavigationStack(path: $navPath) {
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .overlay(
                        getWidgetBg()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2).foregroundStyle(.gray)
                    )
                    .frame(width: viewModel.widgetViewFrameWidth(),
                           height: 150)
                    .overlay(
                        widgetView()
                            .padding(viewModel.widgetViewPadding()))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                monoText(L10n.editWidgetSection)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                    .foregroundStyle(Color.accentColor)

                OptionallyHidden(isHidden: viewModel.hiddenStationsList) {
                    stationListView
                        .onAppear {
                            viewModel.fetchCountryServers()
                        }
                }
                OptionallyHidden(isHidden: !viewModel.hiddenStationsList) {
                    appearanceToggle
                    OptionallyHidden(isHidden: !widgetVm.wAppearance(widget: viewModel.selectedWidget).personalAppearance.wrappedValue) {
                        List {
                            workshopSetupsView
                        }.listStyle(.plain)
                    }
                }
                Spacer()
            }.padding()
                .navigationTitle(viewModel.selectedWidget.rawValue)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showSheet = false
                    }, label: {
                        Image(systemName: AppConstant.closeIcon)
                    }).tint(Asset.darkRed.swiftUIColor)
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationDestination(for: WidgetKind.self) { item in
                TransparentBgView(selectedWidget: item)
            }
            .dynamicTypeSize(.medium)
        }
    }

    /// Custom SwiftUI View providing top Widget View
    @ViewBuilder func widgetView() -> some View {
        switch viewModel.selectedWidget {
        case .simpleSong:
            viewModel.router.showSimpleSongWidget(
                entry: widgetVm.exampleEntry)
        case .shuffle:
            viewModel.router.showShuffleWidget(
                entry: widgetVm.exampleEntry)
        case .rectangle:
            viewModel.router.showRectangleWidget(
                entry: widgetVm.exampleEntry)
        case .widgamp:
            viewModel.router.showWidgampWidget(
                entry: widgetVm.exampleEntry)
        case .boombox:
            viewModel.router.showBoomboxWidget(
                entry: widgetVm.exampleEntry)
        case .theButton:
            viewModel.router.showTheButtonWidget(
                entry: widgetVm.exampleEntry)
        case .theControl:
            viewModel.router.showTheControlWidget(
                entry: widgetVm.exampleEntry)
        case .justArtwork:
            viewModel.router.showJustArtworkWidget(
                entry: widgetVm.exampleEntry)
        case .visualizerSm:
            viewModel.router.showVisualizerSmWidget(entry: widgetVm.exampleGifEntry)
        case .visualizerMd:
            viewModel.router.showVisualizerMdWidget(entry: widgetVm.exampleGifEntry)
        case .radioModernMd:
            viewModel.router.showRadioModernMdWidget(entry: widgetVm.exampleRadioEntry)
        case .radioRetroMd:
            viewModel.router.showRadioRetroMdWidget(entry: widgetVm.exampleRadioEntry)
        }
    }

    @ViewBuilder func getWidgetBg() -> some View {
        if viewModel.selectedWidget == .boombox {
            Asset.boomboxColor.swiftUIColor
        } else if viewModel.selectedWidget == .widgamp &&
                    !widgetVm.wAppearance(widget: viewModel.selectedWidget).personalAppearance.wrappedValue
        {
            Color.black.opacity(0.9)
        } else if viewModel.selectedWidget == .radioRetroMd &&
                    !widgetVm.wAppearance(widget: viewModel.selectedWidget).personalAppearance.wrappedValue
        {
            Asset.radioFg.swiftUIColor
        } else if widgetVm.wAppearance(widget: viewModel.selectedWidget).transparentBg.wrappedValue {
            Color.black
        } else {
            widgetVm.wAppearance(
                widget: viewModel.selectedWidget).personalAppearance.wrappedValue ?
                             widgetVm.wAppearance(
                                widget: viewModel.selectedWidget).bgColor.wrappedValue :
                    .black
        }
    }

    /// Computed property providing List responsible for setting Radio Stations
    var stationListView: some View {
        List {
            Section {
                Button(action: {
                    viewModel.fetchCountryServers()
                }, label: {
                    Label(title: {
                        monoText(L10n.reloadCountries)
                    }, icon: {
                        Image(systemName: AppConstant.reloadIcon)
                    })
                }).foregroundStyle(Asset.darkRed.swiftUIColor)
            }
            Section(L10n.primaryStation) {
                Picker(L10n.country,
                       selection: $viewModel.station1country) {
                    ForEach(viewModel.countries, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
                Picker(L10n.station,
                       selection: $viewModel.station1station) {
                    ForEach(viewModel.country1stations, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
            }
            Section(L10n.secondaryStation) {
                Picker(L10n.country,
                       selection: $viewModel.station2country) {
                    ForEach(viewModel.countries, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
                Picker(L10n.station,
                       selection: $viewModel.station2station) {
                    ForEach(viewModel.country2stations, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
            }
            Section(L10n.thirdStation) {
                Picker(L10n.country,
                       selection: $viewModel.station3country) {
                    ForEach(viewModel.countries, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
                Picker(L10n.station,
                       selection: $viewModel.station3station) {
                    ForEach(viewModel.country3stations, id: \.self) { item in
                        monoText("\(item)")
                            .tag(item)
                    }
                }
            }
            Section(L10n.appearance) {
                appearanceToggle
                OptionallyHidden(isHidden: !widgetVm.wAppearance(widget: viewModel.selectedWidget).personalAppearance.wrappedValue) {
                    workshopSetupsView
                }
            }
        }.listStyle(.plain)
            .pickerStyle(.navigationLink)
    }

    /// Computed property providing Group of Appearance setups
    var workshopSetupsView: some View {
        Group {
            OptionallyHidden(isHidden: viewModel.hiddenBgWorkshop) {
                ColorPicker(selection: widgetVm.wAppearance(
                    widget: viewModel.selectedWidget)
                    .bgColor,
                            supportsOpacity: false, label: {
                    monoText(L10n.bgColor)
                }).pickerStyle(.palette)
            }
            OptionallyHidden(isHidden: viewModel.hiddenFgWorkshop) {
                ColorPicker(selection: widgetVm.wAppearance(
                    widget: viewModel.selectedWidget)
                    .fgColor, supportsOpacity: false,
                            label: {
                    monoText(L10n.fgColor)
                })
            }
            OptionallyHidden(isHidden: viewModel.hiddenDetailWorkshop) {
                ColorPicker(selection: widgetVm.wAppearance(
                    widget: viewModel.selectedWidget)
                    .detailColor, supportsOpacity: false,
                            label: {
                    monoText(L10n.dtColor)
                })
            }
            OptionallyHidden(isHidden: viewModel.hiddenSizeWorkshop) {
                VStack(alignment: .leading) {
                    monoText(L10n.size)
                    Slider(value: widgetVm.wAppearance(widget: viewModel.selectedWidget).size, in: 0.0...2.0)
                }
            }
            OptionallyHidden(isHidden: viewModel.hiddenVisualizationWorkshop) {
                Picker(L10n.visualization, selection: widgetVm.wAppearance(widget: viewModel.selectedWidget).visualization) {
                    ForEach(WidgetGif.getGifList(widgetKind: viewModel.selectedWidget), id: \.self) { item in
                        Text("\(item.rawValue)")
                            .tag(item.rawValue)
                    }
                }.pickerStyle(.menu)
                    .fontDesign(.monospaced)
            }
            OptionallyHidden(isHidden: viewModel.hiddenTransparencyWorkshop) {
                Toggle(isOn: widgetVm.wAppearance(
                    widget: viewModel.selectedWidget)
                    .transparentBg) {
                        monoText(L10n.transparentBg)
                    }
                OptionallyHidden(isHidden: !widgetVm.wAppearance(widget: viewModel.selectedWidget).transparentBg.wrappedValue) {
                    Button(action: {
                        navPath.append(viewModel.selectedWidget)
                    }, label: {
                        monoText(L10n.setupBg)
                            .foregroundStyle(Asset.accentColor.swiftUIColor)
                    })
                }
            }
        }
    }

    /// Computed property providing Toggle Switch enabling custom apperance
    var appearanceToggle: some View {
        Toggle(isOn: widgetVm.wAppearance(
            widget: viewModel.selectedWidget)
            .personalAppearance) {
                monoText(L10n.tailoredDesign)
                    .fontWeight(.bold)
            }
    }

    // MARK: - Initialiser
    init() {
        viewModel = DI.shared.homeVm
        widgetVm = DI.shared.widgetSharedVm
    }
}

#Preview {
    return WorkshopView()
}
