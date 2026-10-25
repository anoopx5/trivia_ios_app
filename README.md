# Trivia Travel

**Trivia Travel** is a Flutter travel discovery app (not a quiz). Browse six countries and 18 famous attractions with large photo cards, travel highlights, suggested visiting times and practical tips.

## Features

- Discover countries: Japan, France, Italy, India, United Arab Emirates and Switzerland.
- See three famous attractions in each country with written mini-guides.
- Search countries, locations, or attraction types.
- Save places to a list during the current app session.
- Polished, responsive material UI with image loading fallback.

All travel content is bundled locally in `lib/travel_data.dart`. Photos are loaded from Unsplash and require an internet connection. For production, review rights for each image and replace temporary remote demo photos with assets you can distribute. Opening hours, tickets and travel restrictions can change; verify official information before your trip. The app does not include bookings or accounts.

## Run locally

```bash
git clone https://github.com/anoopx5/trivia_ios_app.git
cd trivia_ios_app
flutter pub get
flutter run
```

Run `flutter test` for basic checks. On Windows, run an Android device or emulator. On macOS with Xcode, run an iOS Simulator.

## GitHub iOS testing (without a Mac)

Open the **Actions** tab and select the **Flutter iOS Simulator** workflow. It runs on a GitHub-hosted macOS machine, generates native iOS and Android project files if needed, commits them to the repository, runs `flutter analyze` and `flutter test`, builds an unsigned iOS Simulator app, then uploads the `trivia-travel-ios-simulator` artifact.

**Important:** a simulator `Runner.app` build cannot be installed on a physical iPhone. Physical-device installation or TestFlight requires Apple code signing, provisioning, and a device-targeted build. This workflow does not produce a signed IPA.

## Structure

- `lib/main.dart`: screens, navigation, photos and saved-place UI.
- `lib/travel_data.dart`: country and attraction data.
- `test/widget_test.dart`: smoke tests.
- `.github/workflows/ios-ci.yml`: macOS iOS Simulator build workflow.

Flutter package: `trivia_travel_app`. The generated native project uses organization `com.anoopx5`; review the bundle ID before distribution.
