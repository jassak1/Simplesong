//
//  HowToVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

@Observable class HowToVM {
    var router: Router = .init()
    var howToSelection: HowToSelection = .homeScreen
    var helpHeader: String = L10n.howToAddHome
    var helpNotes: [String] = [L10n.howToApp1,
                               L10n.howToApp2,
                               L10n.howToApp3,
                               L10n.howToApp4]

    /// Method returning How To button background color
    func getHowToBg(selectedBtn: HowToSelection) -> Color {
        howToSelection == selectedBtn ? Asset.accentColor.swiftUIColor : Asset.darkGrey.swiftUIColor
    }

    /// Method responsible for taking actions when How To button is pressed
    func onHowToBtn(selectedItem: HowToSelection) {
        howToSelection = selectedItem
        switch selectedItem {
        case .homeScreen:
            helpHeader = L10n.howToAddHome
            helpNotes = [L10n.howToApp1,
                         L10n.howToApp2,
                         L10n.howToApp3,
                         L10n.howToApp4]
        case .appearance:
            helpHeader = L10n.howToEditAppearance
            helpNotes = [L10n.howToEdi1,
                         L10n.howToEdi2,
                         L10n.howToEdi3,
                         L10n.howToEdi4]
        case .transparency:
            helpHeader = L10n.howToAddTransparency
            helpNotes = [L10n.howToTran1,
                         L10n.howToTran2,
                         L10n.howToTran3,
                         L10n.howToTran4,
                         L10n.howToTran5,
                         L10n.howToTran6,
                         L10n.howToTran7,
                         L10n.howToTran8,
                         L10n.howToTran9,
                         L10n.howToTran10,
                         L10n.howToTran11,
                         L10n.howToTran12]
        case .radio:
            helpHeader = L10n.howToSetupRadio
            helpNotes = [L10n.howToRadio1,
                         L10n.howToRadio2,
                         L10n.howToRadio3,
                         L10n.howToRadio4,
                         L10n.howToRadio5,
                         L10n.howToRadio6,
                         L10n.howToRadio7]
        }
    }

    init(router: Router) {
        self.router = router
    }
}
