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

<img width="623" height="608" alt="image" src="https://github.com/user-attachments/assets/776bf74a-6a60-4bbf-a73d-912e8f4ed5d8" />

<img width="488" height="442" alt="image" src="https://github.com/user-attachments/assets/55248672-3ed5-4a82-9e14-30e46b4d4797" />

<img width="501" height="462" alt="image" src="https://github.com/user-attachments/assets/e0807c22-e439-4ee2-96b3-b07e791efabc" />

<img width="654" height="474" alt="image" src="https://github.com/user-attachments/assets/79aad4d1-19cb-4449-906c-8a535ddb5a17" />

<img width="653" height="465" alt="image" src="https://github.com/user-attachments/assets/52ab248c-61e1-4269-9f8a-9ea864acaf43" />

<img width="1362" height="767" alt="Screenshot 2025-11-25 at 2 38 30 PM" src="https://github.com/user-attachments/assets/3c3eafd0-ff73-488d-b7a3-66f43a9af913" />

<img width="1386" height="813" alt="Screenshot 2025-11-25 at 2 35 52 PM" src="https://github.com/user-attachments/assets/63047391-bf78-44f4-b0c7-45f31b6e1964" />


👨‍💻 Developer

Prem Hari

🔗 Instagram: https://www.instagram.com/its_mr_prem_07/

🌟 Support

⭐ If you like the project → Star the repo on GitHub!
