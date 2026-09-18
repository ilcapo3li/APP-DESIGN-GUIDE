class QuoteStep {
  const QuoteStep({required this.labelAr, required this.labelEn});

  final String labelAr;
  final String labelEn;

  String label(String languageCode) => languageCode == 'ar' ? labelAr : labelEn;
}

const List<QuoteStep> kQuoteSteps = [
  QuoteStep(labelAr: 'العقار والمساحة', labelEn: 'Property & Space'),
  QuoteStep(labelAr: 'الموقع', labelEn: 'Location'),
  QuoteStep(labelAr: 'الموعد والعقد', labelEn: 'Date & Contract'),
  QuoteStep(labelAr: 'الميزانية', labelEn: 'Budget'),
  QuoteStep(labelAr: 'المراجعة', labelEn: 'Review'),
];
