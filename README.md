# 📌 EPG Guide - Electronic Programme Guide App

This project is a **Flutter-based Electronic Programme Guide (EPG)** that provides **TV channel listings** and **programme details** with caching and offline support. It utilizes **Riverpod for state management**, **Hive for local caching**, and **Dio for network requests**.

---

## 📂 Project Structure

The project follows a **clean and scalable architecture**:

```
📂 lib/
│── 📂 core/          # Global utilities, services, and router
│── 📂 features/epg/  # EPG feature implementation
│   ├── 📂 pages/        # Screens
│   ├── 📂 widgets/      # UI components
│   ├── 📂 repositories/ # Data management
│   ├── 📂 providers/    # State management with Riverpod
│   ├── 📂 data_sources/ # API & Local database logic
│   ├── 📂 models/       # Data models (freezed + Hive)
└── main.dart
```

---

## 📌 Approach

### 1️⃣ Efficient XML Parsing
The app processes large **EPG XML files in a memory-efficient way** using **Dart’s stream-based XML parsing (`toXmlEvents()`)**, avoiding loading the entire file at once.

- **Channels are fetched once** and stored in local cache.
- **Programmes are streamed on demand** for a selected channel/day.

### 2️⃣ State Management (Riverpod)
State is managed with **Riverpod**, using **`AsyncValue`** to handle UI updates properly:

- `ChannelNotifier` → Manages channel listings.
- `ProgrammeNotifier` → Fetches TV programmes dynamically.

### 3️⃣ Caching Strategy (Hive - Offline Support)
The app follows an **offline-first strategy** with Hive for **local storage**:

- **Channels & Programmes** are stored in a **local database (Hive)**.
- **Each programme entry is timestamped** to track data freshness.

### 4️⃣ Repository Pattern
- `EPGRepository` handles **data fetching logic**, deciding when to pull from **cache vs API**.
- **If offline**, it serves cached data first; when online, it fetches fresh data & updates the cache.

---

## 📌 Features

✔ **TV Channel List** → Displays all available channels.
✔ **Programme Schedule** → View channel’s schedule per day.
✔ **Offline Mode** → Cached data is available **without an internet connection**.
✔ **Pull-to-Refresh** → Users can manually refresh data.

---

## 📸 Screenshots

### 1️⃣ Channel List
Displays all available TV channels.  
![Channel List](/screenshots/channels_page.png)

### 2️⃣ Programme Schedule
View schedule **per channel** and **per day**.  
![Programme Schedule](/screenshots/prgrammes_page.png)

---


## 🛠️ Tech Stack

✅ **Flutter** - UI Framework  
✅ **Riverpod** - State Management  
✅ **AutoRoute** - Navigation
✅ **Dio** - HTTP Client  
✅ **Hive** - Local Storage  
✅ **Freezed** - Data Model Generation  
✅ **Mocktail** - Unit Testing  

