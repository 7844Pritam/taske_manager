

# Task Manager App – Flutter Interview Test

This is a Flutter-based Task Manager App built as part of an interview assignment. The app demonstrates clean architecture, proper state management, responsive UI, and API integration using `Dio`.

---

## Features

* Simulated login with email and password
* Form validation for login and task creation
* Task list fetched from a dummy API (`https://jsonplaceholder.typicode.com/todos`)
* Pull-to-refresh support and sorting (pending tasks on top)
* Task detail screen with the ability to toggle status (complete/incomplete)
* Add new task screen (data stored in memory for demo purposes)
* Light and dark theme support with toggle
* Navigation with basic transitions
* Error handling for API failures

---

## Project Structure

This project follows a modular and scalable folder structure:

```
lib/
├── core/            // App-wide constants, themes, utils
├── models/          // Data models for tasks, users, etc.
├── services/        // API service classes (using Dio)
├── features/
│   ├── auth/        // Login screen and logic
│   ├── home/        // Task list and refresh logic
│   ├── task_detail/ // Task detail screen and status toggle
│   ├── add_task/    // New task creation form
├── providers/       // Riverpod providers and app state
├── main.dart        // Entry point and app-level config
```

---

## State Management

The app uses **Riverpod** for state management.

**Why Riverpod?**

* Simple and testable
* No need for BuildContext to access state
* Works well with modular architecture
* Better support for immutability and scalability

---

## API Integration

* The app fetches tasks from `https://jsonplaceholder.typicode.com/todos`
* Uses the `Dio` package for handling HTTP requests
* Includes basic error handling (try/catch, user-friendly error messages)

---

## How to Run the Project

1. Clone the repository:

   ```
   git clone https://github.com/yourusername/flutter-task-manager.git
   cd flutter-task-manager
   ```

2. Install dependencies:

   ```
   flutter pub get
   ```

3. Run the app:

   ```
   flutter run
   ```

No backend setup is required. Login is simulated using:

* Email: `test@test.com`
* Password: `123456`

---

## Screenshots

<p float="left">
  <img src="https://github.com/user-attachments/assets/52629508-1bba-4196-9c8e-2fcf46a523ab" width="200" />
  <img src="https://github.com/user-attachments/assets/f20905d8-7bb6-4f16-bf27-26c1c117eb3e" width="200" style="margin-right:10px;" />
  <img src="https://github.com/user-attachments/assets/749d9cfb-5646-4ec9-9f6c-e2c9eee9a4ca" width="200" style="margin-right:10px;" />
</p>
<p float="left">
  <img src="https://github.com/user-attachments/assets/a0257837-50d2-4dcd-bb80-75844607fa5f" width="200" style="margin-right:10px;" />
  <img src="https://github.com/user-attachments/assets/1bc605d8-7d3d-45f6-8944-aabcd2813f35" width="200" style="margin-right:10px;" />
  <img src="https://github.com/user-attachments/assets/7b4333db-4675-4778-bcd1-3d2f4a857e3e" width="200" />
</p>



## iOS Build Notes (Theory Section)

### Common Causes of CocoaPods Errors

* Missing or outdated CocoaPods repo
* Pod versions incompatible with current iOS platform or Flutter version
* Changes in Podfile not synced with `pod install`
* M1/M2 MacBook architecture issues (especially with Ruby environment)

### Steps to Fix

1. Run a clean install:

   ```
   flutter clean
   rm ios/Podfile.lock
   rm -rf ios/Pods
   cd ios
   pod install
   cd ..
   ```

2. Update CocoaPods repo:

   ```
   pod repo update
   ```

3. Check your `Podfile`:

   * Make sure platform is set to at least 11.0:

     ```
     platform :ios, '11.0'
     ```

4. For M1/M2 Macs:

   * Use Rosetta to run Terminal or configure Ruby properly via Homebrew
   * Run:

     ```
     sudo arch -x86_64 gem install ffi
     arch -x86_64 pod install
     ```

### Keeping iOS Build Stable

* Always check `flutter doctor` for issues
* Avoid modifying `Generated.xcconfig`
* After Flutter upgrades, clean and reinstall pods
* Keep `CocoaPods`, `Xcode`, and Flutter up to date
