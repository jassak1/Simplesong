# Simplesong
Simplesong provides interactive Music and Radio players Widgets, allowing to control(2) **1. playback of Apple Music** (online/offline Library), and/or **2. playback of on-line radio stations**.
Simplesong provides various Interactive Widgets with different controls and styles. Each Widget's design can be configured by a user via an app, with possibilities ranging from setting various theme colors, enabling transparent background - seamlessly blending with device's wallpaper, or setting preferred radio stations - for Radio Player Widgets.

<img src="https://pbs.twimg.com/media/F6VFZ9HXIAErrll?format=jpg&name=large" alt="Simplesong Home Screen Widgets" width="400"/>

# Stack
- **Architecture**: MVVM with Navigation relying on `NavigationStack`
- **Interface**: SwiftUI, relying on v5.0 with latest features, i.e. using `@Observable` Macro instead of conforming ViewModels to `ObservableObject` and annotating Combine/Observable properties with `@Published` property wrapper.
- **Dependencies:** Using [Translucent](https://github.com/kasimok/Translucent/) library for setting transparent background of Widgets - package added via SPM. **Translucent** trims the screenshot to appropriate size based on iPhone model and Widget position, allowing for user to use trimmed image as Widget's background, acting effectively as a transparent Widget.
- **Others**:
  - **MusicKit** - Native framework used for integrating Simplesong Widgets with Apple Music.
  -  **AppIntent** + **AudioPlaybackIntent** - Intents used for controlling Interactive Widgets via Action Buttons.
  -  **[Radio-Browser API](https://www.radio-browser.info)** - 3rd party API used for providing Radio Stations around the globe.

# Download
<a href="https://apps.apple.com/us/app/simplesong-widgets/id6462826988?itsct=apps_box_badge&amp;itscg=30200" style="display: inline-block; overflow: hidden; border-radius: 13px; width: 150px; height: 40px;"><img src="https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1694995200" alt="Download on the App Store" style="border-radius: 13px; width: 250px; height: 83px;"></a>



<img src="https://tools-qr-production.s3.amazonaws.com/output/apple-toolbox/c51d2b16529a77e0cc1378ac19aa3b2a/20a753fb39b72b77eae2a66aeee3dfa1.png">
