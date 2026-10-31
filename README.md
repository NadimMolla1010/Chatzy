# 💬 Chatzy

Chatzy is a simple real-time chat application built with Flutter and Firebase.

This is a beginner-level learning project to practice Flutter development, Firebase Authentication, Cloud Firestore, and Firebase Storage.

## ✨ Features
- 🔐 User registration and login
- 👥 View registered users
- 💬 One-to-one real-time messaging
- 📎 Send files in chat
- 🎨 Simple custom UI and theme

## 🛠️ Technologies Used
- **Flutter** and **Dart**
- **Firebase Authentication**: login and registration
- **Cloud Firestore**: users and messages
- **Firebase Storage**: file uploads
- **File Picker**: choosing files to send

## 📁 Project Structure
```
lib/
├── components/       # Reusable UI components
├── models/           # Data models
├── pages/            # App screens
├── services/
│   ├── auth/         # Authentication
│   └── chat/         # Chat functionality
├── themes/           # App themes
├── firebase_options.dart
└── main.dart
```

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A Firebase project with **Authentication** (Email/Password), **Cloud Firestore**, and **Storage** enabled

### Run the app
```bash
git clone https://github.com/NadimMolla1010/Chatzy.git
cd Chatzy
flutter pub get
flutter run
```

### Firebase setup
To connect the app to your own Firebase project, configure it with the FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
This regenerates `lib/firebase_options.dart` for your project.

## 📸 Screenshots
Add screenshots to a `screenshots/` folder and link them here:

<!-- ![Login](screenshots/login.png) -->
<!-- ![Chat](screenshots/chat.png) -->

## 📌 Project Status
This is a beginner-level learning project and may be improved with more features in the future.

## 👨‍💻 Author
**Md Nadim Molla** | [LinkedIn](https://linkedin.com/in/nadim-molla) | [GitHub](https://github.com/NadimMolla1010)
