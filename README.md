# Construction Technect

A comprehensive Flutter application for construction management that works seamlessly across web and mobile platforms using GetX for state management and responsive design.

## 🚀 Features

- **Cross-Platform**: Works on Web, Mobile (iOS/Android), and Desktop
- **Responsive Design**: Optimized UI for different screen sizes using responsive_sizer
- **GetX Architecture**: Clean architecture with GetX for state management and navigation
- **Modern UI**: Material Design 3 with custom theming
- **Scalable Structure**: Well-organized codebase with modular architecture
- **Smart Splash Screen**: Shows only on mobile devices with 3-second timer

## 📱 Platform Support

- ✅ **Web**: Chrome, Firefox, Safari, Edge (No splash screen, direct to login)
- ✅ **Mobile**: iOS and Android (Shows splash screen for 3 seconds)
- ✅ **Desktop**: Windows, macOS, Linux (No splash screen, direct to login)

## 🛠️ Tech Stack

- **Framework**: Flutter 3.32.8+
- **State Management**: GetX 4.7.2
- **Responsive Design**: responsive_sizer 3.3.0+1
- **Architecture**: Clean Architecture with GetX Pattern

## 📁 Project Structure

```
lib/
├── app/
│   ├── core/
│   │   └── theme/
│   │       └── app_theme.dart
│   ├── data/
│   ├── modules/
│   │   ├── splash/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   └── login/
│   │       ├── bindings/
│   │       ├── controllers/
│   │       └── views/
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   └── images.dart
├── utils/
│   ├── colors.dart
│   ├── constants.dart
│   ├── text_theme.dart
│   ├── common_button.dart
│   └── imports.dart
└── main.dart
```

## 🎨 Design System

### Colors
- **Primary**: Blue (#2196F3)
- **Secondary**: Orange (#FF9800)
- **Construction Theme**: Blue, Orange, Yellow, Green, Red
- **Text Colors**: Black, Grey, Light Grey
- **Background**: Light Grey (#FAFAFA)

### Typography
- **Font Family**: Lato
- **Responsive Sizing**: Using responsive_sizer package
- **Text Styles**: h1-h6, bodyLarge, bodyMedium, bodySmall, button styles

### Components
- **CommonButton**: Reusable button component with loading states
- **CommonIconButton**: Icon button component
- **Responsive Layout**: Mobile single UI, Tablet/Web same UI

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.32.8 or higher
- Dart SDK 3.8.1 or higher
- GetX CLI (optional but recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd construction-technect
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Install GetX CLI (optional)**
   ```bash
   dart pub global activate get_cli
   ```

4. **Run the application**
   ```bash
   # For Web
   flutter run -d chrome
   
   # For Mobile
   flutter run
   
   # For specific device
   flutter devices
   flutter run -d <device-id>
   ```

## 📱 Splash Screen Behavior

The app has a smart splash screen implementation:

- **Mobile Devices**: Shows splash screen with background image and logo for 3 seconds
- **Web/Tablet**: Skips splash screen and goes directly to login

### Splash Screen Features
- Background image (bricks_background.png)
- App logo (splash_logo.png)
- App name and tagline
- Loading indicator
- 3-second timer
- Smooth navigation to login

## 📱 Responsive Design

The app uses a responsive design approach:

- **Mobile (< 650px)**: Single column layout with splash screen
- **Tablet (650px - 1100px)**: Two-column layout, no splash screen
- **Desktop (> 1100px)**: Multi-column layout, no splash screen

### Usage in Code

```dart
import 'package:construction_technect/utils/imports.dart';

// Responsive sizing
Container(
  width: 100.w,    // 100% of screen width
  height: 50.h,    // 50% of screen height
  padding: EdgeInsets.all(16.w),
)

// Responsive text
Text(
  'Hello World',
  style: MyTexts.h3,  // Responsive font size
)

// Responsive layout
if (Device.screenType == ScreenType.mobile) {
  // Mobile layout
} else {
  // Tablet/Web layout
}
```

## 🎯 Using GetX CLI

### Generate a new page

```bash
# Generate a complete page with controller, view, and binding
get create page:projects

# Generate only a controller
get create controller:projects

# Generate only a view
get create view:projects

# Generate a model
get create model:project
```

### Generated Structure

```
lib/app/modules/projects/
├── bindings/
│   └── projects_binding.dart
├── controllers/
│   └── projects_controller.dart
└── views/
    └── projects_view.dart
```

### Add Routes

After generating a page, add it to `lib/app/routes/app_pages.dart`:

```dart
static final routes = [
  GetPage(
    name: Routes.PROJECTS,
    page: () => const ProjectsView(),
    binding: ProjectsBinding(),
  ),
  // ... other routes
];
```

## 🎨 Customization

### Adding New Colors

Edit `lib/utils/colors.dart`:

```dart
class MyColors {
  // Add your custom colors
  static Color customColor = const Color(0xFF123456);
}
```

### Adding New Text Styles

Edit `lib/utils/text_theme.dart`:

```dart
class MyTexts {
  // Add your custom text styles
  static TextStyle get customStyle => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: MyColors.fontBlack,
    fontFamily: 'Lato',
  );
}
```

### Adding New Components

Create reusable components in `lib/utils/` or `lib/app/widgets/`:

```dart
class CustomWidget extends StatelessWidget {
  // Your widget implementation
}
```

## 📦 Dependencies

### Core Dependencies
- `get: ^4.7.2` - State management and navigation
- `responsive_sizer: ^3.3.0+1` - Responsive design utilities

### Development Dependencies
- `get_cli: ^1.9.1` - Code generation CLI tool

## 🔧 Configuration

### GetX CLI Configuration

The project includes a `get_cli.yaml` file that configures:
- Project structure
- File naming conventions
- Code generation settings
- Import preferences

### Theme Configuration

Edit `lib/app/core/theme/app_theme.dart` to customize:
- Colors
- Typography
- Component styles
- Layout preferences

## 🚀 Deployment

### Web Deployment

```bash
# Build for web
flutter build web

# Deploy to Firebase Hosting
firebase deploy
```

### Mobile Deployment

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## 📝 Best Practices

1. **Use Common Imports**: Always import `package:construction_technect/utils/imports.dart`
2. **Responsive Design**: Use `.w`, `.h`, `.sp` for responsive sizing
3. **GetX Pattern**: Follow the GetX architecture pattern
4. **Component Reusability**: Create reusable components in utils
5. **Consistent Naming**: Follow the established naming conventions
6. **Platform-Specific Logic**: Use `Device.screenType` for platform-specific behavior

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on multiple platforms
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the code examples

---

**Built with ❤️ using Flutter and GetX**

flutter clean
flutter pub get
cd ios
pod install
cd ..