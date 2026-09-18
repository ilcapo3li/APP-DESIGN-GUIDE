# Makatib (مكاتب) — Flutter App

A commercial real-estate app: browse office/commercial property listings and submit a
multi-step RFQ (request for quote). Supports Arabic/English with automatic RTL/LTR
layout, and light/dark theme.

## Getting started

```bash
# 1) Install Flutter if you haven't already
brew install --cask flutter
flutter doctor

# 2) Fetch dependencies
cd makatib_flutter
flutter pub get

# 3) Run
flutter run                # pick a connected device/simulator
flutter run -d chrome      # in the browser
flutter run -d macos       # as a macOS app
```

After changing `pubspec.yaml`'s `flutter_launcher_icons:` / `flutter_native_splash:`
sections or the source logo, regenerate native assets with:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## App structure

```text
lib/
  main.dart                        Entry point: loads SettingsController, wires
                                    MaterialApp's theme/locale to it, launches SplashScreen.

  core/
    settings/
      settings_controller.dart     ChangeNotifier holding ThemeMode + Locale, persisted
                                    via shared_preferences. Also tracks the
                                    "has seen onboarding" flag.
    theme/
      app_theme.dart                Light/dark ThemeData, the AppColors helper (semantic
                                    colors that adapt to the active theme), and the
                                    nextIcon()/previousIcon() direction-aware arrow helpers.
    localization/
      app_strings.dart              Lightweight manual AR/EN string table (no codegen).
                                    Access via AppStrings.of(context).

  features/
    splash/
      splash_screen.dart            Animated logo splash. Routes to OnboardingScreen
                                    (first run) or HomeScreen (returning user).

    onboarding/
      onboarding_data.dart          Content for the 3 onboarding pages.
      onboarding_screen.dart        Swipeable onboarding flow with skip/progress dots.

    home/
      home_screen.dart              App shell: AppBar (brand, theme/language toggles)
                                    + bottom navigation (Account, Matches, Request,
                                    Map, Explore). Explore and Matches are real tabs;
                                    Account/Map are placeholders. "Request" pushes the
                                    RFQ intro screen instead of switching tabs.

    explore/
      explore_screen.dart           Property listing tab: RFQ promo banner + scrollable
                                    property cards (photo, grade badge, match/heart
                                    toggle, area/units stats, pricing).

    properties/
      property_data.dart            Property model + mock listings, and the
                                    formatMoney()/formatArea() display helpers.

    quote/
      quote_data.dart               The 3-step summary shown on the RFQ intro card.
      quote_intro_screen.dart       "Request a Quote" intro card; its CTA opens the
                                    RfqWizardScreen.

    rfq/
      rfq_options.dart              Option lists for every wizard step (property types,
                                    cities/districts, move-in choices, contract lengths,
                                    budgets) plus small formatting helpers (formatDate,
                                    optionLabel).
      rfq_wizard_screen.dart        The 5-step RFQ wizard: property & area, city +
                                    multi-select districts, move-in date (preset or date
                                    picker) & contract length, budget, review — then a
                                    success screen. Includes the cancel-confirmation
                                    dialog and back-to-home navigation.

assets/
  logo.png                          App logo (used for splash + app icon generation).
  onboarding/                       Onboarding page photos.
  units/                            Property listing photos.
```

## Conventions worth knowing

- **Localization**: every user-facing string goes through `AppStrings` (`lib/core/localization/app_strings.dart`), keyed once with both `ar` and `en` values. There's no separate ARB/codegen step — just add a key to the `_values` map and a getter.
- **RTL/LTR**: the app direction follows the active `Locale` automatically. Avoid physical `Icons.arrow_back`/`arrow_forward` and `EdgeInsets.only(left/right: ...)` for anything that should mirror — use `nextIcon(context)`/`previousIcon(context)` (`app_theme.dart`) and `EdgeInsetsDirectional`/`TextAlign.start`/`.end` instead.
- **Light/dark**: screens that build custom (non-`ThemeData`-default) surfaces read colors from `AppColors.of(context)` rather than hardcoding a palette, so they adapt to the active theme.
- **State**: `SettingsController` (theme, locale, onboarding-seen flag) is provided app-wide via `provider`. Screen-local state (wizard steps, cart/matches, form selections) stays local to each `StatefulWidget` — there's no global app state store.
