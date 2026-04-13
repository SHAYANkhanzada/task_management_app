#  Flutter Task Management App 

A comprehensive, production-grade Flutter application developed over a **6-week Internship** period. This project demonstrates a complete journey from basic UI layouts to advanced backend integration and state management.

---

## 📈 6-Week Journey & Features

### 🟢 Phase 1: Foundations & Local Logic

#### 📱 Week 1: Introduction & Basic UI
*   **Environment Setup**: Flutter & Dart installation and environment configuration.
*   **Hello World**: Initializing the project and building the first static layouts.
*   **Basic Containers**: Learning the layout system using `Container`, `Padding`, and `Center`.

#### 🧩 Week 2: Widgets & Layouts
*   **Structural Widgets**: Implementing `Scaffold`, `AppBar`, `Column`, and `Row`.
*   **Interactive Elements**: Adding `Buttons`, `TextFields`, and custom icons.
*   **Styling**: Defining a custom theme with a deep purple aesthetic.

#### 🔢 Week 3: Navigation & Persistence
*   **Counter Logic**: Building a functional counter app with increment/decrement logic.
*   **List-Based Tasks**: Initial implementation of the "To-Do" list using `ListView`.
*   **Local Storage**: Integrating **`shared_preferences`** to persist task and counter data across app restarts.
*   **Navigation**: Implementing basic screen transitions (Splash -> Login -> Home).

---

### 🔵 Phase 2: Advanced Integration (Cycle 2)

#### 📡 Week 4: API Integration & Networking
*   **RESTful APIs**: Fetching real-time user data from [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the `http` package.
*   **Dynamic UI**: Hydrating the "Users" tab with network-fetched records and custom avatars.
*   **Error Handling**: Built-in logic for handling connection timeouts and 403 Forbidden errors (via custom headers).

## 📸 Screenshots & UI

<table style="width:100%">
  <tr>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.33%20PM.jpeg" width="200px" /><br/><b>Splash Screen</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.31%20PM.jpeg" width="200px" /><br/><b>Login Screen</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.32%20PM.jpeg" width="200px" /><br/><b>Signup Screen</b></td>
  </tr>
  <tr>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.31%20PM%20(2).jpeg" width="200px" /><br/><b>Tasks List</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.33%20PM%20(1).jpeg" width="200px" /><br/><b>Add Task Dialog</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.30%20PM%20(2).jpeg" width="200px" /><br/><b>Counter Tab</b></td>
  </tr>
  <tr>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.33%20PM%20(2).jpeg" width="200px" /><br/><b>API Users List</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.32%20PM%20(1).jpeg" width="200px" /><br/><b>User Details</b></td>
    <td align="center"><img src="screenshots/WhatsApp%20Image%202026-04-13%20at%207.47.30%20PM.jpeg" width="200px" /><br/><b>Firebase Profile</b></td>
  </tr>
</table>

### Highlights:
*   **Authentication**: Complete Firebase Auth flow with Splash, Login, and Signup screens.
*   **Task Management**: Modern To-Do interface with Provider-based state updates.
*   **Networking**: Real-time API data parsing with detailed user views.
*   **Profile**: Dynamic profile dashboard synced with Cloud Firestore.

#### 🔐 Week 5: Firebase Authentication & Firestore
*   **User Auth**: Secure **Email/Password** authentication using Firebase.
*   **Cloud Database**: Real-time project data storage with **Cloud Firestore**.
*   **Profile Management**: Syncing user profile data (Name, Email) from Firestore to the app dashboard.

#### 🏗️ Week 6: State Management & UX Polish
*   **Provider Pattern**: Complete architectural refactor using the **Provider** package for scalable state management.
*   **Animations**: Implementing smooth micro-animations for task completion and screen transitions.
*   **Performance**: Optimizing resource usage and refining the code for final submission.

---

## 🛠️ Tech Stack
*   **Framework**: [Flutter](https://flutter.dev/) (3.x)
*   **State Management**: [Provider](https://pub.dev/packages/provider)
*   **Backend**: [Firebase Authentication](https://firebase.google.com/docs/auth) & [Cloud Firestore](https://firebase.google.com/docs/firestore)
*   **Networking**: [http](https://pub.dev/packages/http)
*   **Persistence**: [shared_preferences](https://pub.dev/packages/shared_preferences)

---

## 🚀 Getting Started

### Installation
1.  **Clone the project**:
    ```bash
    git clone https://github.com/SHAYANkhanzada/task_management_app.git
    ```
2.  **Get packages**:
    ```bash
    flutter pub get
    ```
3.  **Firebase Configuration**:
    *   Place your `google-services.json` in `android/app/`.
    *   Ensure the `google-services` plugin is enabled in your Gradle files.
4.  **Launch**:
    ```bash
    flutter run
    ```

---

## 📊 Internship Deliverables Status
- [x] **Week 1-2**: UI Fundamentals & Layouts
- [x] **Week 3**: Local Database & Navigation
- [x] **Week 4**: Networking & API (JSONPlaceholder)
- [x] **Week 5**: Firebase Identity & Firestore
- [x] **Week 6**: State Management & Animations

---

## 👨‍💻 Developer
**Shayan Khanzada**
*Flutter Developers Internship (Complete 6 Weeks)*


