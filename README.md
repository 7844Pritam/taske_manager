Task Manager App — Flutter Developer Interview Test
Setup Instructions
Prerequisites:

Flutter SDK 3.x

Dart SDK

Android Studio or VS Code

Emulator or physical device (iOS or Android)

Clone the repository:

bash
Copy
Edit
git clone https://github.com/your-username/task-manager-app.git
cd task-manager-app
Install dependencies:

bash
Copy
Edit
flutter pub get
Run the app:

bash
Copy
Edit
flutter run
State Management Used: Riverpod
Why Riverpod:

Scalable and clean architecture support

Easily testable state logic

Flexibility with synchronous and asynchronous data

No dependency on BuildContext

How It Was Used:

StateNotifierProvider to manage the task list

Provider for app theme toggle

FutureProvider for asynchronous API fetching

Project Structure (Modular)
css
Copy
Edit
lib/
│
├── core/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── repository/
│   └── services/
│
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── providers/
│
├── main.dart
└── routes.dart
Screenshots or Screen Recording
Include the following:

Login screen

Task list screen with pull-to-refresh

Task details screen

Add task screen

Theme toggle feature

Use a screen recording tool like Loom or OBS, or capture screenshots directly from the emulator or device.

Theory & Problem Solving (10 Marks)
Common CocoaPods Errors in Flutter iOS Build
Typical Errors:

CocoaPods could not find compatible versions for pod "XYZ"

Unable to find a specification for 'XYZ'

Causes:
Outdated CocoaPods repository

Invalid or missing pod version

iOS platform version in Podfile is too low

Incompatible dependencies

Ruby environment issues

Apple M1/M2 chip configuration issues

Steps to Diagnose and Fix:
Clean and reset pods:

bash
Copy
Edit
flutter clean
cd ios
rm -rf Pods Podfile.lock
pod install
Update CocoaPods repo:

bash
Copy
Edit
pod repo update
Set minimum iOS platform version in Podfile:

ruby
Copy
Edit
platform :ios, '12.0'
Run dependency commands in order:

bash
Copy
Edit
flutter pub get
cd ios
pod install
For M1/M2 Mac users:

Use Rosetta terminal to install CocoaPods:

bash
Copy
Edit
arch -x86_64 sudo gem install cocoapods
Use arch command to run CocoaPods:

bash
Copy
Edit
arch -x86_64 pod install
Best Practices for a Stable Flutter iOS Environment
Regularly run flutter doctor

Use consistent Ruby environments (rbenv or rvm)

Commit the Podfile.lock to ensure dependency consistency across teams

Update CocoaPods regularly:

bash
Copy
Edit
sudo gem install cocoapods
Avoid mixing system and user-installed gems

Use version managers if working in teams or on CI/CD