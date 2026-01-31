# Secure Vault - Mobile App

![Secure Vault Logo](personal_vault_mobile/assets/logo.png)

A secure cloud storage mobile application built with Flutter and Supabase.

## Features

- 🔐 **Secure Authentication** - Email/password login with persistent sessions
- 📁 **Folder Tree View** - Organize files in hierarchical folder structure
- 📤 **File Upload** - Upload files, photos, and documents
- 📥 **File Download** - Download files to your device
- 📸 **Camera Integration** - Capture and upload photos directly
- 🗑️ **File Management** - Delete unwanted files
- 🔄 **Cross-Platform Sync** - Syncs with web app
- 🌙 **Dark Mode** - Automatic light/dark theme support

## Download

Download the latest APK:
- [**Secure Vault v1.0.0 APK**](personal_vault_mobile/build/app/outputs/flutter-apk/app-release.apk) (49.2 MB)

## Installation

1. Download the APK file from the link above
2. Enable "Install from Unknown Sources" in your Android settings
3. Open the downloaded APK file
4. Follow the installation prompts
5. Launch Secure Vault and sign in or create an account

## Screenshots

The app features:
- Clean, modern UI with Material Design
- Folder tree navigation
- File categorization with icons
- Camera capture functionality
- Secure file storage

## Tech Stack

- **Frontend**: Flutter 3.x
- **Backend**: Supabase
- **Storage**: Supabase Storage
- **Authentication**: Supabase Auth
- **State Management**: flutter_bloc

## Building from Source

### Prerequisites
- Flutter SDK (>=3.0.0)
- Android Studio / Xcode
- Dart SDK

### Steps

```bash
# Clone the repository
git clone https://github.com/BIPINRVANJARA/Secure-Vault-app.git
cd Secure-Vault-app/personal_vault_mobile

# Install dependencies
flutter pub get

# Run the app
flutter run

# Build release APK
flutter build apk --release
```

## Configuration

The app connects to a Supabase backend. The configuration is in:
```
lib/core/config/supabase_config.dart
```

## Features in Detail

### Authentication
- Persistent login sessions
- Automatic token refresh
- Secure password handling

### File Management
- Upload files from device storage
- Upload photos from gallery
- Capture photos with camera
- Download files to device
- Delete files with confirmation
- Folder-based organization

### Folder Tree
- Hierarchical folder structure
- Expand/collapse folders
- File count display
- Nested folder support

## License

This project is open source and available for personal use.

## Support

For issues or questions, please open an issue on GitHub.

---

**Built with ❤️ using Flutter and Supabase**
