# Task Management App

A simple Flutter application created as part of the Flutter Development Interns Task (Week 1–3).

## Features

### Week 1: Basic UI & Navigation
- **Splash Screen:** Displayed initially for 2 seconds (Bonus Challenge).
- **Login Screen:** Input fields for email and password.
- **Form Validation:** Validates the email format and ensures the password is not empty before allowing login.
- **Navigation:** Moves to the Home Screen upon successful validation.

### Week 2: Data Management & Persistent Storage
- **Local Storage:** Utilizes the `shared_preferences` package for data persistence.
- **State Management:** Uses `setState` for widget state management.
- **Counter Tab:** A simple counter allowing the user to increase or decrease values, saved locally.

### Week 3: Task Management App
- **Task List:** A tab displaying a list of tasks.
- **Task Operations:** Add new tasks, mark tasks as complete, and delete tasks.
- **Data Persistence:** All task states are saved across app restarts using `SharedPreferences`.
- **UI Enhancements:** Deep purple theme, custom app bars with action buttons, floating action buttons, and icons to create a functional and appealing interface.

## Getting Started

### Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Set up Android Studio or VS Code

### Installation
1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd task_management_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Built With
- [Flutter](https://flutter.dev/)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
