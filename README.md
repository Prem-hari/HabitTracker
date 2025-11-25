🚀 HabitTracker — Build Habits, One Day at a Time

A simple and beautiful Flutter mobile app that helps users build consistency, track streaks, and develop habits daily.

<p align="center"> <img src="https://raw.githubusercontent.com/flutter/website/master/src/assets/images/shared/brand/flutter/logo/flutter-lockup.png" width="220"> </p>

🚀 Features

✨ User Authentication (Login / Register) using Firebase

📆 Create, Track, and Update Habits

🔥 Streak system - Complete habits and grow your streak

📊 Habit Analytics Dashboard (Streak, Completed, Skipped, Insights)

🖼️ Beautiful UI similar to modern habit apps

🗄️ Firebase Realtime Database storage

📱 Responsive Flutter UI – Android & iOS


📦 Tech Stack
| Technology                     | Purpose               |
| ------------------------------ | --------------------- |
| **Flutter**                    | UI & App              |
| **Firebase Auth**              | User Login / Register |
| **Firebase Realtime Database** | Habit storage         |
| **Riverpod**                   | State management      |
| **Dart**                       | Programming language  |


📁 Project Structure

HabitTracker/
 ├── android/
 
 ├── ios/
 
 ├── lib/
 
 │   ├── models/
 
 │   ├── providers/
 
 │   ├── screens/
 
 │   ├── services/
 
 │   ├── widgets/
 
 │   └── main.dart
 
 ├── pubspec.yaml
 
 ├── README.md
 


🧑‍💻 Getting Started

📌 1. Clone the Repository

git clone https://github.com/Prem-hari/HabitTracker.git

cd HabitTracker

📌 2. Install Dependencies

flutter pub get

📌 3. Setup Firebase 🔥

Go to https://console.firebase.google.com

Create a project → Add Android/iOS App

Download google-services.json (Android) or GoogleService-Info.plist (iOS)

Put them in the correct folders:

android/app/google-services.json
ios/Runner/GoogleService-Info.plist

📌 4. Enable Firebase Auth

Firebase Console → Authentication → Sign-in Method

✔️ Enable Email / Password

📌 5. Setup Firebase RealTime DB

Firebase Console → Database → Realtime Database

Change Rules:

{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}

📌 6. Run App

flutter run

📱 Core Screens

🔑 Auth Screen

Create account

Login

Firebase Auth integration

🏠 Home Screen

Habit list

Today count

Total streak

“Complete habit” interaction

➕ Add Habit Screen

Select icon

Choose colors

Save to database

📊 Habit Detail Dashboard

Completed counts

Success Rate

Best streak

7-week history visualization

👤 Profile Screen

User info

Sign out

App settings (future)

🖼️ UI Preview

