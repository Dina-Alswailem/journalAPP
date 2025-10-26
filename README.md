
## 📓 Journali App

**Journali** is a lightweight and elegant journaling application designed to help you capture your thoughts, memories, and daily moments. The app provides a clean and modern **iOS-inspired Glass UI**, allowing users to create, edit, delete, search, and bookmark journal entries effortlessly.

---

### ✨ Features

* 📝 Create, edit, and delete journal entries
* 🔍 Instant search for quick filtering
* 🔖 Bookmark important notes
* 🎨 Modern **Glassmorphism UI** inspired by iOS design
* 📌 Smooth scrolling experience with polished UI elements
* 🧠 Built using **MVVM architecture** for clean separation of logic and interface

---

### 🧠 Project Structure

```
📁 JournalApp/
│
├── 📁 Model/
│   └── JournalModel.swift
│
├── 📁 ViewModel/
│   └── JournalViewModel.swift
│
├── 📁 Views/
│   ├── SplashScreen.swift
│   ├── EmptyStateView.swift
│   ├── JournalCardView.swift
│   └── NewJournalCard.swift
│
├── 📁 Components/
│   ├── SearchBarView.swift
│   └── SortMenuView.swift
│
└── 📁 Popups/
    ├── DeleteAlertView.swift
    └── EditSheetView.swift
```

---

### 🧩 Tech Stack

* **SwiftUI** for UI development
* **MVVM Architecture** for scalable code structure
* **UIKit Bridge** for transparent sheet backgrounds
* **Custom Animations & Glass Effects** for modern user experience

---

### 🚀 How to Run

1. Open the project in **Xcode 15 or later**
2. Select a simulator or a physical iPhone device
3. Press **Run ▶️** to launch the app

> ✅ *No database setup needed — data is managed in-memory using the ViewModel.*

---

### 📈 Future Enhancements

* 🗂️ Persistent storage using **CoreData or iCloud**
* 🔒 Face ID / Passcode journal lock
* 📌 Tags & categories for journal organization
* 🌙 Light mode support
* 🗓️ Calendar view for navigating entries by date

---

### 👩🏻‍💻 Author

**Dina Alswailem**
iOS & Front-End Developer 🇸🇦

[GitHub](https://github.com/Dina-Alswailem) • [LinkedIn](https://www.linkedin.com/in/dina-alswailem)
