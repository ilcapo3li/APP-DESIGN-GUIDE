import 'package:flutter/widgets.dart';

class AppStrings {
  AppStrings(this.languageCode);

  final String languageCode;

  static AppStrings of(BuildContext context) =>
      AppStrings(Localizations.localeOf(context).languageCode);

  static const Map<String, Map<String, String>> _values = {
    'brand': {'ar': 'مكاتب', 'en': 'Makatib'},
    'tagline': {'ar': 'مساحات تصنع الفرق', 'en': 'Spaces that make the difference'},
    'skip': {'ar': 'تخطي', 'en': 'Skip'},
    'next': {'ar': 'التالي', 'en': 'Next'},
    'getStarted': {'ar': 'ابدأ الآن', 'en': 'Get Started'},
    'welcomeTitle': {'ar': 'أهلاً بك في مكاتب', 'en': 'Welcome to Makatib'},
    'welcomeBody': {
      'ar': 'اعثر على المساحة المكتبية المناسبة لأعمالك.',
      'en': 'Find the right office space for your business.',
    },
    'startNow': {'ar': 'ابدأ الآن', 'en': 'Start Now'},
    'quoteLabel': {'ar': 'مسعى عرض سعر', 'en': 'Request a Quote'},
    'quoteTitle': {'ar': 'لم تجد المساحة المناسبة؟', 'en': "Can't find the right space?"},
    'quoteDesc': {
      'ar': 'أجب عن خمس خطوات قصيرة وسنرتب لك العروض الأقرب لاحتياجك خلال ٢٤ ساعة.',
      'en': "Answer five quick steps and we'll match you with the closest offers to your needs within 24 hours.",
    },
    'startRequest': {'ar': 'ابدأ المسعى', 'en': 'Start Request'},
    'rfqTagline': {'ar': 'تأجير العقارات التجارية', 'en': 'Commercial Property Leasing'},
    'rfqHeadline': {'ar': 'احتياجك التجاري', 'en': 'Your Business Needs'},
    'continueLabel': {'ar': 'متابعة', 'en': 'Continue'},
    'submitRequest': {'ar': 'إرسال المسعى', 'en': 'Submit Request'},
    'newRequest': {'ar': 'مسعى جديد', 'en': 'New Request'},
    'step1Question': {'ar': 'ما نوع العقار والمساحة المطلوبة؟', 'en': 'What property type and space do you need?'},
    'requiredArea': {'ar': 'المساحة المطلوبة', 'en': 'Required Area'},
    'step2Question': {'ar': 'أين تفضّل موقع العقار؟', 'en': 'Where would you prefer the property to be located?'},
    'step3Question': {'ar': 'متى الانتقال وما مدة العقد؟', 'en': 'When will you move in, and for how long?'},
    'moveInDate': {'ar': 'موعد الانتقال', 'en': 'Move-in Date'},
    'contractLength': {'ar': 'مدة العقد', 'en': 'Contract Length'},
    'step4Question': {'ar': 'ما ميزانيتك السنوية؟', 'en': "What's your annual budget?"},
    'chooseBudgetToContinue': {'ar': 'اختر الميزانية للمتابعة', 'en': 'Choose a budget to continue'},
    'reviewTitle': {'ar': 'كل شيء جاهز', 'en': "Everything's Ready"},
    'reviewDesc': {'ar': 'راجع التفاصيل قبل إرسال مسعاك.', 'en': 'Review the details before submitting your request.'},
    'propertyTypeLabel': {'ar': 'نوع العقار', 'en': 'Property Type'},
    'preferredLocationLabel': {'ar': 'الموقع المفضل', 'en': 'Preferred Location'},
    'moveInAndContractLabel': {'ar': 'الانتقال والعقد', 'en': 'Move-in & Contract'},
    'annualBudgetLabel': {'ar': 'الميزانية السنوية', 'en': 'Annual Budget'},
    'successBadge': {'ar': 'تم بنجاح', 'en': 'Success'},
    'successTitle': {'ar': 'وصلنا مسعاك', 'en': 'We Received Your Request'},
    'successDesc': {
      'ar': 'سنراجع احتياجك ونتواصل معك بالعروض المناسبة خلال 24 ساعة.',
      'en': "We'll review your needs and reach out with suitable offers within 24 hours.",
    },
    'availableProperties': {'ar': 'العقارات المتاحة', 'en': 'Available Properties'},
    'cart': {'ar': 'السلة', 'en': 'Cart'},
    'cartEmpty': {'ar': 'لم تختر أي عقار بعد', 'en': "You haven't selected any properties yet"},
    'sqmShort': {'ar': 'م²', 'en': 'sqm'},
    'cancelRequestTitle': {'ar': 'إلغاء المسعى؟', 'en': 'Cancel Request?'},
    'cancelRequestBody': {
      'ar': 'هل تريد إلغاء المسعى؟ سيتم فقد كل البيانات المدخلة.',
      'en': 'Are you sure you want to cancel this quote request? All entered data will be lost.',
    },
    'cancelRequestConfirm': {'ar': 'نعم، إلغاء', 'en': 'Yes, Cancel'},
    'cancelRequestDismiss': {'ar': 'رجوع', 'en': 'Keep Going'},
    'backToHome': {'ar': 'العودة للرئيسية', 'en': 'Back to Home'},
    'themeTooltip': {'ar': 'الوضع الليلي/النهاري', 'en': 'Theme'},
    'languageTooltip': {'ar': 'اللغة', 'en': 'Language'},
    'areaLabel': {'ar': 'المساحة', 'en': 'Area'},
    'availableUnitsLabel': {'ar': 'وحدات متاحة', 'en': 'Available Units'},
    'annuallyLabel': {'ar': 'سنويًا', 'en': 'Annually'},
    'startingFromLabel': {'ar': 'يبدأ من', 'en': 'Starting from'},
    'perSqmSuffix': {'ar': '/م²', 'en': '/sqm'},
    'account': {'ar': 'حسابي', 'en': 'Account'},
    'matches': {'ar': 'المطابقات', 'en': 'Matches'},
    'requestTab': {'ar': 'المسعى', 'en': 'Request'},
    'mapTab': {'ar': 'الخريطة', 'en': 'Map'},
    'exploreTab': {'ar': 'استكشف', 'en': 'Explore'},
    'comingSoon': {'ar': 'قريبًا', 'en': 'Coming Soon'},
    'noMatchesYet': {'ar': 'لم تختر أي وحدات بعد', 'en': "You haven't matched any units yet"},
    'cityLabel': {'ar': 'المدينة', 'en': 'City'},
    'chooseCityHint': {'ar': 'اختر المدينة', 'en': 'Choose a city'},
    'chooseCityFirst': {'ar': 'اختر المدينة أولًا لعرض الأحياء', 'en': 'Choose a city first to see districts'},
    'districtsLabel': {'ar': 'الأحياء', 'en': 'Districts'},
    'orPickSpecificDate': {'ar': 'أو اختر تاريخًا محددًا (اختياري)', 'en': 'Or pick a specific date (optional)'},
    'changeDate': {'ar': 'تغيير', 'en': 'Change'},
    'clearDate': {'ar': 'إزالة', 'en': 'Clear'},
    'notSpecified': {'ar': 'غير محدد', 'en': 'Not specified'},
  };

  String _t(String key) => _values[key]?[languageCode] ?? _values[key]?['en'] ?? key;

  String get brand => _t('brand');
  String get tagline => _t('tagline');
  String get skip => _t('skip');
  String get next => _t('next');
  String get getStarted => _t('getStarted');
  String get welcomeTitle => _t('welcomeTitle');
  String get welcomeBody => _t('welcomeBody');
  String get startNow => _t('startNow');
  String get quoteLabel => _t('quoteLabel');
  String get quoteTitle => _t('quoteTitle');
  String get quoteDesc => _t('quoteDesc');
  String get startRequest => _t('startRequest');
  String get rfqTagline => _t('rfqTagline');
  String get rfqHeadline => _t('rfqHeadline');
  String get continueLabel => _t('continueLabel');
  String get submitRequest => _t('submitRequest');
  String get newRequest => _t('newRequest');
  String get step1Question => _t('step1Question');
  String get requiredArea => _t('requiredArea');
  String get step2Question => _t('step2Question');
  String get step3Question => _t('step3Question');
  String get moveInDate => _t('moveInDate');
  String get contractLength => _t('contractLength');
  String get step4Question => _t('step4Question');
  String get chooseBudgetToContinue => _t('chooseBudgetToContinue');
  String get reviewTitle => _t('reviewTitle');
  String get reviewDesc => _t('reviewDesc');
  String get propertyTypeLabel => _t('propertyTypeLabel');
  String get preferredLocationLabel => _t('preferredLocationLabel');
  String get moveInAndContractLabel => _t('moveInAndContractLabel');
  String get annualBudgetLabel => _t('annualBudgetLabel');
  String get successBadge => _t('successBadge');
  String get successTitle => _t('successTitle');
  String get successDesc => _t('successDesc');
  String get availableProperties => _t('availableProperties');
  String get cart => _t('cart');
  String get cartEmpty => _t('cartEmpty');
  String get sqmShort => _t('sqmShort');
  String get cancelRequestTitle => _t('cancelRequestTitle');
  String get cancelRequestBody => _t('cancelRequestBody');
  String get cancelRequestConfirm => _t('cancelRequestConfirm');
  String get cancelRequestDismiss => _t('cancelRequestDismiss');
  String get backToHome => _t('backToHome');
  String get themeTooltip => _t('themeTooltip');
  String get languageTooltip => _t('languageTooltip');
  String get areaLabel => _t('areaLabel');
  String get availableUnitsLabel => _t('availableUnitsLabel');
  String get annuallyLabel => _t('annuallyLabel');
  String get startingFromLabel => _t('startingFromLabel');
  String get perSqmSuffix => _t('perSqmSuffix');
  String get account => _t('account');
  String get matches => _t('matches');
  String get requestTab => _t('requestTab');
  String get mapTab => _t('mapTab');
  String get exploreTab => _t('exploreTab');
  String get comingSoon => _t('comingSoon');
  String get noMatchesYet => _t('noMatchesYet');
  String get cityLabel => _t('cityLabel');
  String get chooseCityHint => _t('chooseCityHint');
  String get chooseCityFirst => _t('chooseCityFirst');
  String get districtsLabel => _t('districtsLabel');
  String get orPickSpecificDate => _t('orPickSpecificDate');
  String get changeDate => _t('changeDate');
  String get clearDate => _t('clearDate');
  String get notSpecified => _t('notSpecified');
}
