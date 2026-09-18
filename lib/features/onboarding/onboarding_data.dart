class OnboardingPageData {
  const OnboardingPageData({
    required this.imageAsset,
    required this.eyebrowAr,
    required this.eyebrowEn,
    required this.titleAr,
    required this.titleEn,
    required this.descAr,
    required this.descEn,
  });

  final String imageAsset;
  final String eyebrowAr;
  final String eyebrowEn;
  final String titleAr;
  final String titleEn;
  final String descAr;
  final String descEn;

  String eyebrow(String languageCode) => languageCode == 'ar' ? eyebrowAr : eyebrowEn;
  String title(String languageCode) => languageCode == 'ar' ? titleAr : titleEn;
  String desc(String languageCode) => languageCode == 'ar' ? descAr : descEn;
}

const List<OnboardingPageData> kOnboardingPages = [
  OnboardingPageData(
    imageAsset: 'assets/onboarding/onboarding_1.jpg',
    eyebrowAr: 'وجهتك للأعمال',
    eyebrowEn: 'Your Business Destination',
    titleAr: 'مساحتك القادمة تبدأ هنا',
    titleEn: 'Your Next Space Starts Here',
    descAr: 'اكتشف أفضل المساحات التجارية في أحياء الرياض الحيوية.',
    descEn: "Discover the best commercial spaces in Riyadh's vibrant districts.",
  ),
  OnboardingPageData(
    imageAsset: 'assets/onboarding/onboarding_2.jpg',
    eyebrowAr: 'اختيارات مدروسة',
    eyebrowEn: 'Curated Choices',
    titleAr: 'قرارات أسرع، خيارات أوضح',
    titleEn: 'Faster Decisions, Clearer Choices',
    descAr: 'حدد احتياجك وسنرتب لك الخيارات الأقرب لطموح أعمالك.',
    descEn: "Tell us what you need and we'll match options to your ambitions.",
  ),
  OnboardingPageData(
    imageAsset: 'assets/onboarding/onboarding_3.jpg',
    eyebrowAr: 'خطوتك التالية',
    eyebrowEn: 'Your Next Step',
    titleAr: 'جاهز لمقر يصنع الفرق؟',
    titleEn: 'Ready for a space that makes the difference?',
    descAr: 'ابدأ طلبك الآن ودعنا نصل بك إلى المساحة المناسبة.',
    descEn: 'Start your request now and let us find you the right space.',
  ),
];
