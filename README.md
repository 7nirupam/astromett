# ASTROMETT — Early Access Landing Platform

> *"Some Connections Are Written in the Stars."*

**Astromett** is a premium relationship-technology web application built with Flutter and Dart. It unites the timeless depth of traditional Indian Vedic astrology (Kundali matching, 8 Kootas & 36 Gunas) with Western zodiac compatibility (Sun, Moon, and Rising archetypes) and dignified astrologer counsel to help intentional individuals discover meaningful connections and marriage.

---

## ✦ Technology Stack

- **Framework**: Flutter 3.44.4 (Stable Channel)
- **Language**: Dart 3.12.2
- **Platform**: Web (HTML5 / CanvasKit / WebGL)
- **Typography**: Google Fonts (`Cormorant Garamond` for headings, `DM Sans` for body)
- **Localization & Formatting**: `intl` (v0.20.3)
- **Styling Architecture**: Custom brand design system with responsive design container and theme

---

## ✦ Brand Identity & Design System

Astromett features an art-directed celestial aesthetic with a deep midnight palette accented by warm antique gold:

- **Midnight Navy**: `#090D20` — Primary cosmic background
- **Deep Cosmic Purple**: `#17152D` — Atmospheric mid-tones & card containers
- **Royal Plum**: `#352044` — Subtle astrological highlights & accent glows
- **Antique Gold**: `#B77A45` — Editorial borders, dividers, and secondary accents
- **Champagne Gold**: `#E8C99D` — Primary branding, CTA gradients, and celestial stars
- **Warm Ivory**: `#F3E8D7` — High-legibility editorial headings & prominent text
- **Muted Lavender**: `#A09CBD` — Secondary descriptive copy

---

## ✦ Project Architecture

```
lib/
├── app.dart                                # MaterialApp entry, dark theme & scroll behaviors
├── main.dart                               # Minimal bootstrap
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart             # Brand copy, breakpoints, asset constants
│   └── theme/
│       ├── app_colors.dart                 # Color palette & gradients
│       ├── app_theme.dart                  # Material3 dark theme configuration
│       └── app_typography.dart             # Cormorant Garamond & DM Sans typography hierarchy
│
├── features/
│   └── landing/
│       ├── screens/
│       │   └── landing_screen.dart         # Main scrollable landing page coordinator
│       └── widgets/
│           ├── navigation_bar.dart         # Sticky blurred navbar with responsive layout
│           ├── mobile_navigation.dart      # Touch-friendly mobile drawer menu
│           ├── hero_section.dart           # Cinematic hero with cosmic background & CTAs
│           ├── about_section.dart          # Editorial breakdown of Astromett's philosophy
│           ├── how_it_works_section.dart   # 3-step celestial onboarding journey
│           ├── features_section.dart       # Vedic Kundali, Western Zodiac & Astrologer showcases
│           ├── astrologer_section.dart     # Classical lineage & dignified human guidance
│           ├── early_access_section.dart   # Conversion container for cohort registration
│           ├── registration_form.dart      # Form with age validation, error states & simulated reservation
│           └── footer_section.dart         # Brand footer with modal policy disclosures
│
└── shared/
    └── widgets/
        ├── primary_button.dart             # Gold animated button with hover glow & loading indicator
        ├── responsive_container.dart       # Breakpoint helpers & max-width container (1200px)
        └── section_heading.dart            # Editorial heading with celestial star ornament
```

---

## ✦ Responsive Breakpoints Tested & Verified

The landing platform has been built and tested across all standard device viewports:

| Viewport Category | Resolution | Layout Behavior |
| :--- | :--- | :--- |
| **Small Mobile** | 360 × 800 | Stacked hero, centered brand, hamburger drawer, full-width touch CTAs |
| **iPhone-Sized Mobile** | 375 × 667 | Proportional typography, stacked cards, full-width glass CTA |
| **Standard Mobile** | 390 × 844 | Fitted typography, stacked cards, full-width registration |
| **Large Mobile** | 430 × 932 | Comfortable touch targets, responsive date picker |
| **Tablet Portrait** | 768 × 1024 | Expanded card padding, compact navigation drawer |
| **Tablet Landscape** | 1024 × 768 | Desktop horizontal navigation (4 links), split editorial showcases |
| **Laptop** | 1366 × 768 | Desktop navigation, full split hero with celestial negative space |
| **Desktop Standard** | 1440 × 900 | Full split hero, multi-column feature showcase |
| **Large Desktop** | 1920 × 1080 | Constrained to 1200px max content width with centered composition |

---

## ✦ Installation & Local Development

### Prerequisites
- Flutter SDK (v3.44+ or stable)
- Chrome or Edge browser installed

### Setup Commands
```bash
# Clone or navigate to the workspace
cd "d:\Astromatt Early Access"

# Fetch dependencies
flutter pub get

# Run static analysis
flutter analyze

# Execute automated tests across viewports and forms
flutter test

# Launch in Google Chrome
flutter run -d chrome
```

---

## ✦ Early Access Registration Flow & API Integration Points

The registration form (`lib/features/landing/widgets/registration_form.dart`) is currently a frontend-only implementation with client-side validation:

1. **Validation Rules**:
   - `First Name`: Required, minimum 2 characters, alphabetic format check.
   - `Email Address`: Required, standard RFC email regex validation.
   - `Date of Birth`: Native date picker restricted to adult applicants (18+ years) and preventing future dates.
   - `Duplicate Prevention`: Client-side deduplication against multiple submissions in a session.
2. **Success State**:
   - Displays a celebratory reservation card with a unique reservation code (`#ASTRO-XXXX`).
   - Allows users to register another profile if desired.
3. **Backend Integration Hook**:
   - To connect to a live backend (Firebase, Supabase, Node/Go REST API), replace the `Future.delayed` call inside `_handleSubmit()` in `registration_form.dart` with an authenticated HTTP POST request to your registration endpoint:
   ```dart
   // Example future API call:
   // final response = await http.post(
   //   Uri.parse('https://api.astromett.com/v1/early-access'),
   //   headers: {'Content-Type': 'application/json'},
   //   body: jsonEncode({
   //     'firstName': _nameController.text.trim(),
   //     'email': email,
   //     'dateOfBirth': _selectedDate!.toIso8601String(),
   //   }),
   // );
   ```

---

## ✦ Assets & Fallbacks

- Primary cinematic background: `assets/images/astromett_cosmic_background.png`
- If the image is ever missing, the widget automatically falls back to a multi-stop cosmic gradient (`AppColors.cosmicGradient`) without throwing runtime errors or disrupting page layout.
