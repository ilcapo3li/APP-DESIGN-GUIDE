import 'package:flutter/material.dart';

const Color kGold = Color(0xFFF2A93E);
const Color kNavy = Color(0xFF0B1220);
const Color kOffWhite = Color(0xFFF7F7F5);
const Color kBlack = Color(0xFF0B0B0B);
const Color kWhite = Color(0xFFFFFFFF);

/// Semantic colors that read correctly in both light and dark mode,
/// used by screens (RFQ wizard, quote intro) that build their own
/// surfaces instead of relying on ThemeData's defaults.
class AppColors {
  AppColors(this.isDark);

  factory AppColors.of(BuildContext context) =>
      AppColors(Theme.of(context).brightness == Brightness.dark);

  final bool isDark;

  Color get background => isDark ? kNavy : kOffWhite;
  Color get surface => isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.04);
  Color get chip => isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05);
  Color get textPrimary => isDark ? kWhite : kBlack;
  Color get textSecondary => isDark ? Colors.white70 : Colors.black54;
  Color get textTertiary => isDark ? Colors.white54 : Colors.black45;
  Color get textFaint => isDark ? Colors.white38 : Colors.black38;
  Color get border => isDark ? Colors.white12 : Colors.black12;
  Color get track => isDark ? Colors.white24 : Colors.black26;
}

/// "Continue / next" arrow: points left under RTL (reading progresses
/// right-to-left), right under LTR. Icons.arrow_back/forward are plain
/// glyphs that never auto-mirror, so callers must pick per-direction.
IconData nextIcon(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl ? Icons.arrow_back : Icons.arrow_forward;

/// "Back / previous" arrow: the mirror image of [nextIcon].
IconData previousIcon(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl ? Icons.arrow_forward : Icons.arrow_back;

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: kOffWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kGold,
          brightness: Brightness.light,
          primary: kGold,
          onPrimary: kBlack,
          surface: kOffWhite,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kBlack,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kGold,
            foregroundColor: kBlack,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kNavy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kGold,
          brightness: Brightness.dark,
          primary: kGold,
          onPrimary: kBlack,
          surface: kNavy,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: kWhite,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kGold,
            foregroundColor: kBlack,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      );
}
