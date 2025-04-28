# YOUR UPI

YOUR UPI is a Flutter-based Android app for scanning UPI QR codes, managing scan history locally, generating personal UPI QR codes, and enabling copy/share functionalities.

## Features

- Scan UPI QR codes using device camera
- Parse and display recipient information
- Save scan history locally with search and filter
- Generate UPI QR codes from user input
- Copy and share UPI details
- Redirect to official UPI apps for payments
- Light and Dark theme support
- Privacy-focused with local data storage only

## Getting Started

### Prerequisites

- Flutter SDK installed (https://flutter.dev/docs/get-started/install)
- Android device or emulator

### Running the App Locally

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run` to launch the app on a connected device or emulator

### Building APK for Release

You can build the APK locally with:

```
flutter build apk --release
```

The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`.

### Using CodeMagic for Cloud Build

1. Create a free account on [CodeMagic](https://codemagic.io)
2. Connect your GitHub repository containing this project
3. Configure build settings for Flutter Android release build
4. Start the build and download the generated APK
5. Install the APK on your Android device

## Project Structure

- `lib/` - Flutter source code
- `assets/` - App assets like logo
- `pubspec.yaml` - Flutter dependencies and assets
- `README.md` - This file

## License

This project is provided as-is for demonstration purposes.

---

Thank you for using YOUR UPI!
