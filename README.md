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

- **Navigation:** Use the top navigation (shared `MainHeader`) to move between `Home`, `Collections`, `SALE!`, `About`, and `The Print Shack` menu.
  - On mobile (< 600px width), navigation buttons collapse into a menu icon (PopupMenuButton).
  - Desktop view shows all navigation buttons inline.
- **Shopping Cart:** 
  - Click the shopping bag icon in the header to view cart contents.
  - Add items from Collections, Sale, or Print Shack personalisation pages.
  - Cart displays item total, quantity controls, and order summary with subtotal, tax, and grand total.
- **Collections Page:**
  - Browse products with category and price range filters.
  - Sort by name, price (ascending/descending), or newest.
  - Click a product to view details, select color/size/quantity, and add to cart.
- **Sale Page:**
  - Similar filtering and sorting as Collections.
  - Browse discounted products and add to cart.
- **Print Shack:**
  - Choose how many lines of text to print (one or two).
  - Enter custom text and see live preview over sample product images.
  - Select quantity, then press `ADD TO CART` to add personalised item to cart.

Running tests

```powershell
# Run all tests
flutter test

# Run a single test file
flutter test test/cart_test.dart
```

Notes: widget tests run in headless mode — network images can fail there. Tests use `setSurfaceSize(1200, 900)` for consistent viewport sizing across desktop and mobile layouts.

---

4. Project Structure & Technologies
-----------------------------------

Top-level layout

```
lib/
├─ main.dart                    # App entry + routes
├─ cart_page.dart               # Shopping cart page
├─ product_page.dart            # Product detail UI
├─ sale_page.dart               # Sale products page
├─ collections_page.dart        # Collections/products page
├─ print_shack_page.dart        # Personalisation page
├─ about_print_shack.dart       # About page
├─ about_us_page.dart           # About us page
├─ authentication_page.dart     # Authentication page
├─ models/
│  └─ products.dart             # Product and ProductCategory classes, ProductDatabase
└─ widgets/
   ├─ main_header.dart          # Shared header with responsive navigation
   └─ main_footer.dart          # Shared footer

assets/images/                  # Local images
test/                           # Widget tests
  ├─ cart_test.dart             # Cart functionality tests
  └─ ...other page tests...
```

Technologies

- Flutter (Dart) — primary UI toolkit
- **State Management:** CartService singleton pattern for global cart state management
- **Responsive Design:** MediaQuery-based mobile breakpoint (600px), LayoutBuilder for adaptive layouts
- **Navigation:** Named routes, Navigator.pushNamed, MaterialPageRoute
- **Data Model:** Const Product/ProductCategory/ProductDatabase classes with 10+ products
- **UI Widgets:** LayoutBuilder, GridView, Table (with FlexColumnWidth), SingleChildScrollView, PopupMenuButton, DropdownButton, Image.asset, Image.network (with errorBuilder), TextField, IconButton
- **Filtering & Sorting:** DropdownButton for category, price range, and sort options on Collections and Sale pages

Configuration

- Ensure `pubspec.yaml` lists `assets/images/` under the `flutter:` > `assets:` section so local images are bundled.

---

5. Known Issues
---------------

- Network images may fail in widget tests (test environment blocks network requests). Tests use `Image.asset` fallbacks with errorBuilder to handle this gracefully.
- The app is a demo and does not implement backend services: cart persistence, payments, and full authentication are not implemented (placeholders only).
- Mobile responsiveness is tested at the 600px breakpoint; smaller devices may require further adjustments.

Suggested improvements

- Implement cart persistence using `shared_preferences` or local database.
- Add payment integration (Stripe, PayPal).
- Implement proper authentication with backend service.
- Add more comprehensive integration tests for cart workflows.
- Add CI/CD pipeline for automated testing.

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

