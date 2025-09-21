# task_flow

## TaskFlow - Task Management App 📱

A comprehensive Flutter todo application with advanced features including statistics, weather integration, and multi-language support.

## ✨ Features

### Core Functionality

- ✅ **Task Management**: Create, edit, complete, and delete tasks
- 📊 **Advanced Statistics**: Completion rates, productivity charts, streaks
- 🌤️ **Weather Integration**: Real-time weather data with location services
- 🔔 **Smart Notifications**: Scheduled reminders with timezone support
- 🌐 **Multi-language Support**: Polish and English localization
- 📱 **Responsive Design**: Material Design with dark/light theme support

### Technical Features

- 💾 **Offline Storage**: Local Hive database for reliability
- 🔒 **Secure Configuration**: Environment-based API key management
- 🎯 **Smart Fallbacks**: Mock data when services unavailable
- 📈 **Performance Optimized**: Efficient data structures and caching
- 🧪 **Well Tested**: Comprehensive unit and widget tests

### Weather Integration

- 🌍 **Real Location**: GPS-based weather for your current location
- 🔄 **Auto-refresh**: Weather updates when switching to tasks view
- 🎭 **Demo Mode**: Automatic fallback with realistic mock data
- 🔐 **Security**: API keys never hardcoded in production builds

## 🚀 Getting Started

### Prerequisites

- Flutter 3.9.2+
- Dart 3.0+
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/RobertSobczyk/TaskFlow.git
   cd TaskFlow
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Setup Environment Configuration**

   Copy the example environment file:

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and add your OpenWeatherMap API key:

   ```bash
   # Get your free API key from: https://openweathermap.org/api
   WEATHER_API_KEY=your_openweathermap_api_key_here
   WEATHER_API_BASE_URL=https://api.openweathermap.org/data/2.5/weather
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

### Demo Mode

If you don't have an API key, the app will automatically run in demo mode with mock weather data.

## 🏗️ Architecture & Technical Decisions

### Current Implementation (Demo/Recruitment App)

This application was built as a **recruitment demonstration project** with the following technical choices:

- **State Management**: Simple `setState()` and `StatefulWidget`
- **HTTP Client**: Standard `http` package
- **Local Storage**: `Hive` for simplicity
- **Architecture**: Basic Flutter widget tree structure

### Production-Ready Considerations

For a **production application**, the following architectural improvements would be implemented:

#### State Management

```dart
// Instead of setState(), we would use:
flutter_bloc: ^8.1.3      # BLoC pattern for scalable state management
flutter_hooks: ^0.20.3    # Hooks for cleaner widget code
hooked_bloc: ^1.4.0       # Integration between flutter_hooks and flutter_bloc
```

#### Networking

```dart
// Instead of basic http package:
dio: ^5.3.2              # Advanced HTTP client with interceptors
retrofit: ^4.0.3         # Type-safe API client generation
```

#### Architecture Pattern

```dash
lib/
├── core/
│   ├── di/              # Dependency Injection (GetIt)
│   ├── network/         # Dio interceptors, error handling
│   └── utils/
├── data/
│   ├── repositories/    # Repository pattern implementation
│   ├── datasources/     # Remote & Local data sources
│   └── models/          # Data transfer objects
├── domain/
│   ├── entities/        # Business logic entities
│   ├── repositories/    # Abstract repository interfaces
│   └── usecases/        # Single responsibility business logic
└── presentation/
    ├── bloc/           # BLoC classes for state management
    ├── pages/          # Screen widgets
    └── widgets/        # Reusable UI components
```

### Why Simple Architecture for This Demo?

1. **Recruitment Focus**: Demonstrates core Flutter skills without overengineering
2. **Time Constraints**: Faster development for MVP features
3. **Learning Curve**: Easier to understand and review code structure
4. **Scope**: Limited feature set doesn't require complex architecture

## 📱 Platform Support & Testing

### Supported Platforms

- ✅ **Android** - Fully tested and supported
- ❓ **iOS** - Not tested (see testing recommendations below)

### Testing Recommendations

⚠️ **Important Note**: This application has been developed and tested exclusively on **Android devices**.

#### For Android Testing

```bash
# Build and run on Android device/emulator
flutter run --debug
flutter build apk --release
```

#### For iOS Testing

While the code should theoretically work on iOS due to Flutter's cross-platform nature, **it has not been tested on iOS devices**. If you plan to test on iOS:

1. **Recommended**: Test on Android first to verify functionality
2. **iOS Requirements**: Ensure you have:
   - Xcode installed (macOS required)
   - iOS Simulator or physical iOS device
   - Valid iOS development certificates

3. **Potential iOS Issues**:
   - Location permissions might need iOS-specific configuration
   - Notification settings may require iOS platform adjustments
   - Weather service integration should work but hasn't been verified

#### Production Considerations

For production deployment, thorough testing on both platforms would include:

- Device-specific testing (various screen sizes)
- iOS permission handling verification
- Platform-specific notification testing
- Performance testing on both platforms

**Recommendation**: Use Android for evaluation and testing of this recruitment demo application.
