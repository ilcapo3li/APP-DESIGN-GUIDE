# مكاتب — تطبيق Flutter

شاشة افتتاحية (سبلاش) بالأبيض والأسود مع شعار مكاتب.

## التشغيل على الماك

```bash
# 1) تثبيت Flutter (لو مش متثبت)
brew install --cask flutter
flutter doctor

# 2) داخل مجلد المشروع
cd makatib_flutter
flutter create . --project-name makatib   # يولّد مجلدات ios/android/macos
flutter pub get

# 3) التشغيل
flutter run -d macos     # كتطبيق ماك
flutter run -d chrome    # في المتصفح
flutter run              # على محاكي iPhone (بعد فتح Simulator)
```

ملاحظة: `flutter create .` لا يحذف `lib/main.dart` ولا `assets/` ولا `pubspec.yaml` الموجودين.

## الملفات
- `lib/main.dart` — السبلاش سكرين + الشاشة الرئيسية
- `assets/logo.png` — شعار مكاتب
