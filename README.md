# 🚀 Flutter Task Management App (Internship Cycle 2)

A premium, state-of-the-art Flutter application built for the **Flutter Developers Internship**. This project showcases advanced concepts including RESTful API integration, Firebase Authentication, Cloud Firestore, and State Management using the Provider pattern.

---

## 🌟 Key Features

### 📡 Week 4: API Integration & Networking
*   **Dynamic Data Fetching**: Retrieves user data from [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the `http` package.
*   **Interactive ListView**: Displays a clean, scrollable list of users with customized avatars.
*   **User Profiles**: Detailed profile view for each user showing name, email, and personal info.
*   **Network Resilience**: Robust error handling with user-friendly error messages and a retry mechanism.
*   **UX Polish**: Integrated circular progress indicators for seamless loading states.

### 🔐 Week 5: Firebase Authentication & Database
*   **Identity Management**: Fully functional Email/Password authentication flow (Signup & Login).
*   **Cloud Persistence**: Real-time integration with **Cloud Firestore** to store and sync user metadata.
*   **Auth-Guarded UI**: Personalized profile dashboard that hydrates data directly from the user's Firestore document.
*   **Secure Session**: Smooth logout functionality and session management.

### 🏗️ Week 6: State Management & Optimization
*   **Provider Pattern**: Refactored core logic to use the `Provider` package for clean, scalable state management.
*   **Real-time Updates**: Task additions, completions, and deletions update the UI instantly without manual `setState` calls.
*   **Animations**: Subtle micro-animations and polished UI transitions for a premium user experience.
*   **Architecture**: Optimized project structure following best practices for production-ready Flutter apps.

---

## 🛠️ Tech Stack
*   **Framework**: [Flutter](https://flutter.dev/)
*   **Language**: [Dart](https://dart.dev/)
*   **State Management**: [Provider](https://pub.dev/packages/provider)
*   **Backend**: [Firebase Auth](https://firebase.google.com/docs/auth) & [Cloud Firestore](https://firebase.google.com/docs/firestore)
*   **Networking**: [http](https://pub.dev/packages/http)
*   **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)

---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK installed
*   An active Firebase project

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/flutter-task-manager-internship.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Firebase Setup**:
    *   Add your `google-services.json` to `android/app/`.
    *   Add your `GoogleService-Info.plist` to `ios/Runner/`.
4.  **Run the app**:
    ```bash
    flutter run
    ```

---

## 📸 Screenshots & UI
*   **Login/Signup**: Clean, modern forms with validation.
*   **Task List**: Professional To-Do interface with animated completion toggles.
*   **User List**: Beautifully parsed API data with random avatar generation.
*   **Profile**: Real-time data sync with Cloud Firestore.

---

## 📝 Deliverables Status
- [x] Week 4: API Integration & Networking
- [x] Week 5: Firebase Auth & Firestore
- [x] Week 6: Provider State Management & Final Polish

---

## 👨‍💻 Developer
**Shayan Khanzada**
*Flutter Internship Cycle 2 (Weeks 4-6)*

---
*Created with ❤️ and Antigravity AI.*
