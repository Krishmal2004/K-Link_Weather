# K-Link Weather Application ☀️🌧️

A modern Flutter weather application with user authentication and profile management, built with Supabase backend integration.

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?style=flat&logo=dart)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=flat&logo=supabase)

## ✨ Features

- **Real-time Weather Data**: Get current weather information for any location
- **User Authentication**: Secure login and sign-up functionality powered by Supabase
- **User Profiles**: Personalized profile page for each user
- **Beautiful UI**: Clean and intuitive interface with animated text elements
- **Cross-platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux

## 📱 Screenshots

The app includes:
- Home Page with welcoming interface
- Weather Page displaying current weather conditions
- Login/Sign-up pages with elegant design

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK (^3.9.2)
- A code editor (VS Code, Android Studio, or IntelliJ)
- Supabase account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Krishmal2004/K-Link_Weather.git
   cd K-Link_Weather
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase** (Optional - if setting up your own instance)
   - Update the Supabase URL and anon key in `lib/main.dart`
   - Set up authentication in your Supabase dashboard

4. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- **flutter**: SDK for building cross-platform apps
- **supabase_flutter** (^2.12.0): Backend as a Service for authentication and data
- **http** (^1.1.0): HTTP client for API requests
- **animated_text_kit** (^4.2.2): Beautiful text animations
- **cupertino_icons** (^1.0.8): iOS-style icons

## 🏗️ Project Structure

```
lib/
├── main.dart              # App entry point
├── home_page.dart         # Home screen
├── loging.dart            # Login screen
├── signUp.dart            # Sign-up screen
├── weather_page.dart      # Weather display screen
├── profilePage.dart       # User profile screen
├── services/              # Backend services
└── widget/                # Reusable widgets

assets/
├── home_page.jpg
├── weather_page.jpg
└── logingPage.jpg
```

## 🛠️ Development

### Available Platforms

This app supports:
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### Running Tests

```bash
flutter test
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## 🌐 API Integration

This app uses weather API services to fetch real-time weather data. Make sure to:
1. Obtain an API key from your weather service provider
2. Configure the API key in the appropriate service file

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**Krishmal2004**
- GitHub: [@Krishmal2004](https://github.com/Krishmal2004)

## 📧 Contact

For questions or feedback, please open an issue on GitHub.

## 🙏 Acknowledgments

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- Weather API providers
- The Flutter community

---

Made with ❤️ using Flutter
