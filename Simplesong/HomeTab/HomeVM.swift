//
//  HomeVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

@Observable class HomeVM {
    // MARK: - Properties
    /// Router property
    var router: Router = .init()
    /// MusicService property
    var musicService: MusicServiceProto = MusicService()
    /// Property indicating which `WidgetCategory` button is selected
    var activeButton: WidgetCategory = .modern
    /// Array containing all Widgets based on their category
    var allWidgets: [WidgetKind] {
        get { activeButton == .modern ? WidgetKind.modernWidgets : WidgetKind.retroWidgets }
    }
    /// ID of ScrollView
    var scrollId = UUID()
    /// Property indicating which Widget has been selected for Workshop View
    var selectedWidget: WidgetKind = .radioModernMd
    /// Property indicating whether fullScreen modal sheet is presented (for Workshop View)
    var showSheet = false
    /// Property indicating whether to display Modal sheet with In App Purchase View
    var showModal = false
    /// Boolean flag indicating whether `selectedWidget` allows to update bg color
    var hiddenBgWorkshop: Bool {
        get { !WidgetKind.canEditBgColor.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allows to update fg color
    var hiddenFgWorkshop: Bool {
        get { !WidgetKind.canEditFgColor.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allows to update detail color
    var hiddenDetailWorkshop: Bool {
        get { !WidgetKind.canEditDetailColor.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allows to update size
    var hiddenSizeWorkshop: Bool {
        get { !WidgetKind.canEditSize.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allows to update transparent image
    var hiddenTransparencyWorkshop: Bool {
        get { !WidgetKind.canEditTransparency.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allows to update visualization
    var hiddenVisualizationWorkshop: Bool {
        get { !WidgetKind.canEditVisualization.contains(selectedWidget) }
    }
    /// Boolean flag indicating whether `selectedWidget` allowd to select radio stations
    var hiddenStationsList: Bool {
        get { !WidgetKind.canSelectStations.contains(selectedWidget) }
    }

    // MARK: - StationsView properties and methods
    /// String array of all available countries with radio stations
    var countries: [String] = []
    /// String array of all available Radio Stations for first country

    var country1radios: [RadioStations] = []
    /// String array holding unique stations for first country
    var country1stations: [String] = []
    /// String holding country of selected first station
    var station1country: String = UserDefaults.getValue(for: .primaryStationCountry, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .primaryStationCountry, setValue: station1country)
            Task { @MainActor in
                let stationsResult = await fetchCountryStations(country: station1country,
                                                                serverCountry: currentRadioPrefix)
                country1radios = stationsResult.0
                country1stations = stationsResult.1
            }
        }
    }
    /// String holding first selected station
    var station1station: String = UserDefaults.getValue(for: .primaryStationRadio, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .primaryStationRadio, setValue: station1station)
            let station1info = country1radios.first(where: { $0.name == station1station } )
            UserDefaults.setData(data: station1info, for: .primaryStationInfo)
        }
    }

    /// String array of all available Radio Stations for second country
    var country2radios: [RadioStations] = []
    /// String array holding unique stations for second country
    var country2stations: [String] = []
    /// String holding country of selected second station
    var station2country: String = UserDefaults.getValue(for: .secondaryStationCountry, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .secondaryStationCountry, setValue: station2country)
            Task { @MainActor in
                let stationsResult = await fetchCountryStations(country: station2country,
                                                                serverCountry: currentRadioPrefix)
                country2radios = stationsResult.0
                country2stations = stationsResult.1
            }
        }
    }
    /// String holding second selected station
    var station2station: String = UserDefaults.getValue(for: .secondaryStationRadio, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .secondaryStationRadio, setValue: station2station)
            let station2info = country2radios.first(where: { $0.name == station2station } )
            UserDefaults.setData(data: station2info, for: .secondaryStationInfo)
        }
    }

    /// String array of all available Radio Stations for third country
    var country3radios: [RadioStations] = []
    /// String array holding unique stations for third country
    var country3stations: [String] = []
    /// String holding country of selected third station
    var station3country: String = UserDefaults.getValue(for: .thirdStationCountry, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .thirdStationCountry, setValue: station3country)
            Task { @MainActor in
                let stationsResult = await fetchCountryStations(country: station3country,
                                                                serverCountry: currentRadioPrefix)
                country3radios = stationsResult.0
                country3stations = stationsResult.1
            }
        }
    }
    /// String holding third selected station
    var station3station: String = UserDefaults.getValue(for: .thirdStationRadio, defaultValue: "") {
        didSet {
            UserDefaults.setValue(for: .thirdStationRadio, setValue: station3station)
            let station3info = country3radios.first(where: { $0.name == station3station } )
            UserDefaults.setData(data: station3info, for: .thirdStationInfo)
        }
    }
    /// String holding current radio-browser api prefix
    var currentRadioPrefix = "at1"

    // MARK: - Public methods
    /// Method responsible for retrieving Category Button background color
    ///
    ///  - Parameters:
    ///     - selectedItem: Value of `WidgetCategory` type indicating current selection
    ///
    ///  - Returns: SwiftUI Color used as button's background
    func getCategoryBtnBgColor(selectedItem: WidgetCategory) -> Color {
        selectedItem == activeButton ? .accentColor : Asset.darkGrey.swiftUIColor
    }

    /// Method responsible for retrieving Category Button foreground color
    ///
    ///  - Parameters:
    ///     - selectedItem: Value of `WidgetCategory` type indicating current selection
    ///
    ///  - Returns: SwiftUI Color used as button's foreground
    func getCategoryBtnFgColor(selectedItem: WidgetCategory) -> Color {
        selectedItem == activeButton ? .black : .white
    }

    /// Method responsible for taking action when Category Button is pressed
    ///
    ///  - Parameters:
    ///     - category: Value of `WidgetCategory` type
    func categoryButtonAction(category: WidgetCategory) {
        activeButton = category
        scrollId = UUID()
    }

    /// Method responsible for taking action when the Edit Widget button is pressed
    ///
    ///  - Parameters:
    ///     - widget: Value of `WidgetKind` type
    func onWorkshopBtn(widget: WidgetKind) {
        selectedWidget = widget
        showSheet = true
    }

    /// Method providing padding for Widget View available inside WorkshopView
    ///
    ///  - Returns:
    ///     - `Double` value used as horizontal padding
    func widgetViewPadding() -> Double {
        if WidgetKind.smallWidgets.contains(selectedWidget) {
            return 10
        } else {
            return 20
        }
    }

    /// Method providing frame Width for Widget View available inside WorskhopView
    ///
    ///  - Returns:
    ///     - `Double` value used as frame width
    func widgetViewFrameWidth() -> Double {
        if WidgetKind.smallWidgets.contains(selectedWidget) {
            return 150
        } else {
            return 300
        }
    }

    /// Method responsible for fetching Country servers and optionally fetching stations servers
    func fetchCountryServers() {
        Task { @MainActor in
            do {
                try await fetchCountries(serverUrl: "https://at1.api.radio-browser.info/json/countries")
                await setStations()
            } catch {
                try await fetchCountries(serverUrl: "https://nl1.api.radio-browser.info/json/countries")
                currentRadioPrefix = "nl1"
                await setStations()
            }
        }
    }

    // MARK: - Private methods
    /// Private method reponsible for fetching radio-browser countries endpoint
    /// Succesfull response of available countries populates observable `countries` array property
    private func fetchCountries(serverUrl: String) async throws {
        guard let url = URL(string: serverUrl) else {
            return
        }
        let dataResult = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode([RadioCountries].self, from: dataResult.0 )
        let uniqueCountries = Set(decoded.map { $0.name } )
        countries = Array(uniqueCountries).sorted()
    }

    /// Private method responsible for fetching radio-browser stations endpoint with specific country
    ///
    ///  - Returns:
    ///     - Tuple - 0 - Array of `RadioStations` and 1 - Array of  `String`
    private func fetchCountryStations(country: String,
                                      serverCountry: String) async -> ([RadioStations], [String]) {
        do {
            guard let url = URL(string: "https://\(serverCountry).api.radio-browser.info/json/stations/search?country=\(country)&codec=mp3") else {
                return ([], [])
            }
            let dataResult = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([RadioStations].self, from: dataResult.0 )
            let uniqueStations = Set(decoded.map { $0.name } )
            return (decoded, Array(uniqueStations).sorted())
        } catch {
            print(error)
            return ([], [])
        }
    }

    /// Private method responsbile for setting Radio stations based on country
    private func setStations() async {
        if !station1country.isEmpty {
            let stationsResult = await fetchCountryStations(country: station1country,
                                                            serverCountry: currentRadioPrefix)
            country1radios = stationsResult.0
            country1stations = stationsResult.1
        }
        if !station2country.isEmpty {
            let stationsResult2 = await fetchCountryStations(country: station2country,
                                                             serverCountry: currentRadioPrefix)
            country2radios = stationsResult2.0
            country2stations = stationsResult2.1
        }
        if !station3country.isEmpty {
            let stationsResult3 = await fetchCountryStations(country: station3country,
                                                             serverCountry: currentRadioPrefix)
            country3radios = stationsResult3.0
            country3stations = stationsResult3.1
        }
    }

    // MARK: - Initialiser
    init(router: Router,
         musicService: MusicServiceProto) {
        self.router = router
        self.musicService = musicService
        if musicService.authStatus == .notDetermined {
            musicService.requestAuthorization()
        }
    }
}
