import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kOnboardingSeenKey = 'onboarding_seen';

class SettingsController extends ChangeNotifier {
  SettingsController({
    required ThemeMode themeMode,
    required Locale locale,
    required SharedPreferences prefs,
  })  : _themeMode = themeMode,
        _locale = locale,
        _prefs = prefs;

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale_code';

  final SharedPreferences _prefs;

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Locale _locale;
  Locale get locale => _locale;

  static Future<SettingsController> load() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString(_themeModeKey);
    final storedLocale = prefs.getString(_localeKey);

    return SettingsController(
      themeMode: switch (storedTheme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      locale: Locale(storedLocale ?? 'ar'),
      prefs: prefs,
    );
  }

  void toggleTheme() {
    final isCurrentlyDark = _themeMode == ThemeMode.dark ||
        (_themeMode == ThemeMode.system &&
            WidgetsBinding
                    .instance.platformDispatcher.platformBrightness ==
                Brightness.dark);
    _themeMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setString(_themeModeKey, _themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    _prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  void toggleLocale() {
    setLocale(_locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
  }

  Future<void> setOnboardingSeen() => _prefs.setBool(kOnboardingSeenKey, true);

  bool get hasSeenOnboarding => _prefs.getBool(kOnboardingSeenKey) ?? false;
}
