# Union Shop — Flutter Coursework

This repository is a Flutter implementation of a student-union shop website. It is a small, educational e‑commerce demo app that demonstrates responsive layouts, navigation, simple product pages, and a small "Print Shack" personalisation flow.

This README describes how to run the app, the main files and pages, testing notes, and some implementation details so you can continue development easily.

 # Union Shop (Flutter)

This repository is a small educational Flutter app that demonstrates a student-union shop website with responsive pages, a shared header/footer, product pages, and a "Print Shack" personalisation flow.

---

1. Project Title and Description
--------------------------------

- **Project Title:** Union Shop (Flutter)
- **Short Description:** A demo Flutter application that showcases responsive layouts, navigation, product UI, and a small interactive personalisation feature called "The Print Shack".
- **Highlights:** shared `MainHeader`/`MainFooter`, product pages, `PrintShack` personalisation (live preview), and an `About Print Shack` page.

---

2. Installation and Setup
-------------------------

Prerequisites

- Flutter SDK (stable channel). Install from https://flutter.dev
- A suitable editor (VS Code recommended) with Flutter and Dart extensions

Clone and prepare the project (PowerShell)

```powershell
git clone https://github.com/<YOUR-USERNAME>/union_shop.git
cd union_shop
flutter pub get
```

Run the app

```powershell
# Run in Chrome (web)
flutter run -d chrome

# Run on Windows desktop (if enabled)
flutter run -d windows
```

If you see issues, run `flutter doctor` and follow the guidance.

---

3. Usage
--------

- Navigation: use the top navigation (shared `MainHeader`) to move between `Home`, `Collections`, `SALE!`, `About` and `The Print Shack` menu.
- The Print Shack menu contains two entries: `About` (navigates to `/about-print-shack`) and `Personalisation` (navigates to `/print-shack`).
- Print Shack features:
  - Choose how many lines of text to print (one or two).
  - Enter custom text lines and see a live preview over sample product images.
  - Select thumbnails and quantity, then press `ADD TO CART` (currently a SnackBar placeholder).

Running tests

```powershell
# Run all tests
flutter test

# Run a single test file
flutter test test/about_print_shack_test.dart
```

Notes: widget tests run in headless mode — network images can fail there. Prefer `Image.asset` in tests or mock network images; this project includes test-side helpers to drain async exceptions in some tests.

---

4. Project Structure & Technologies
-----------------------------------

Top-level layout

```
lib/
├─ main.dart                 # App entry + routes
├─ product_page.dart         # Product detail UI
├─ sale_page.dart
├─ collections_page.dart
├─ print_shack_page.dart     # Personalisation page
├─ about_print_shack.dart    # About page
└─ widgets/
   ├─ main_header.dart      # Shared header
   └─ main_footer.dart      # Shared footer

assets/images/              # Local images
test/                       # Widget tests
```

Technologies

- Flutter (Dart) — primary UI toolkit
- Uses core Flutter widgets: `LayoutBuilder`, `GridView`, `SingleChildScrollView`, `Image.asset`, `PopupMenuButton`, etc.

Configuration

- Ensure `pubspec.yaml` lists `assets/images/` under the `flutter:` > `assets:` section so local images are bundled.

---

5. Known Issues
---------------

- Network images may fail in widget tests (test environment blocks network requests). Tests in this repo handle this with fallbacks or by draining async exceptions.
- The app is a demo and does not implement backend services: cart persistence, payments, and full authentication are not implemented (placeholders only).
- Some pages previously had inline headers; prefer using the shared `MainHeader` for consistent behavior.

Suggested fixes

- Use `Image.asset` for determinism in tests.
- Add integration tests and CI to catch regressions early.

---

6. Contribution Guidelines
--------------------------

- Fork the repository and create a feature branch for changes.
- Make small, focused commits with clear messages.
- Add or update widget tests for new functionality.
- Open a pull request describing the change and any manual steps to verify it.

If this repo is part of coursework, follow your institution's policies for collaboration and attribution.

---

7. Contact Information
----------------------

Replace the placeholders below with your real contact info:

- **Maintainer:** Your Name
- **Email:** your.email@example.com
- **GitHub:** https://github.com/<YOUR-USERNAME>

If you'd like, I can also run `flutter analyze` and `flutter test` in this workspace and help fix any failures (for example: missing assets or image load errors). Just tell me which action to run next.
---



## Known Limitations

