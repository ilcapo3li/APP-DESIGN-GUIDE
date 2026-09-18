class RfqOption {
  const RfqOption({required this.value, required this.labelAr, required this.labelEn});

  final String value;
  final String labelAr;
  final String labelEn;

  String label(String languageCode) => languageCode == 'ar' ? labelAr : labelEn;
}

const List<RfqOption> kPropertyTypeOptions = [
  RfqOption(value: 'commercial_center', labelAr: 'مركز تجاري', labelEn: 'Commercial Center'),
  RfqOption(value: 'office', labelAr: 'مكتب', labelEn: 'Office'),
  RfqOption(value: 'shared_office', labelAr: 'مكاتب مشتركة', labelEn: 'Shared Office'),
  RfqOption(value: 'warehouse', labelAr: 'مستودع', labelEn: 'Warehouse'),
];

class CityData {
  const CityData({required this.value, required this.labelAr, required this.labelEn, required this.districts});

  final String value;
  final String labelAr;
  final String labelEn;
  final List<RfqOption> districts;

  String label(String languageCode) => languageCode == 'ar' ? labelAr : labelEn;
}

const List<CityData> kCities = [
  CityData(
    value: 'riyadh',
    labelAr: 'الرياض',
    labelEn: 'Riyadh',
    districts: [
      RfqOption(value: 'kafd', labelAr: 'مركز الملك عبدالله المالي', labelEn: 'King Abdullah Financial District'),
      RfqOption(value: 'olaya', labelAr: 'العليا', labelEn: 'Olaya'),
      RfqOption(value: 'king_fahd_road', labelAr: 'طريق الملك فهد', labelEn: 'King Fahd Road'),
      RfqOption(value: 'al_malqa', labelAr: 'الملقا', labelEn: 'Al Malqa'),
      RfqOption(value: 'al_yasmin', labelAr: 'الياسمين', labelEn: 'Al Yasmin'),
      RfqOption(value: 'no_preference', labelAr: 'لا يوجد تفضيل', labelEn: 'No Preference'),
    ],
  ),
  CityData(
    value: 'jeddah',
    labelAr: 'جدة',
    labelEn: 'Jeddah',
    districts: [
      RfqOption(value: 'al_rawdah', labelAr: 'الروضة', labelEn: 'Al Rawdah'),
      RfqOption(value: 'al_shati', labelAr: 'الشاطئ', labelEn: 'Al Shati'),
      RfqOption(value: 'al_tahlia', labelAr: 'التحلية', labelEn: 'Al Tahlia'),
      RfqOption(value: 'obhur_north', labelAr: 'أبحر الشمالية', labelEn: 'Obhur North'),
      RfqOption(value: 'no_preference', labelAr: 'لا يوجد تفضيل', labelEn: 'No Preference'),
    ],
  ),
  CityData(
    value: 'dammam',
    labelAr: 'الدمام',
    labelEn: 'Dammam',
    districts: [
      RfqOption(value: 'corniche', labelAr: 'الكورنيش', labelEn: 'Corniche'),
      RfqOption(value: 'al_faisaliah', labelAr: 'الفيصلية', labelEn: 'Al Faisaliah'),
      RfqOption(value: 'al_shati_dammam', labelAr: 'الشاطئ', labelEn: 'Al Shati'),
      RfqOption(value: 'no_preference', labelAr: 'لا يوجد تفضيل', labelEn: 'No Preference'),
    ],
  ),
];

List<RfqOption> districtsForCity(String? cityValue) {
  if (cityValue == null) return const [];
  for (final city in kCities) {
    if (city.value == cityValue) return city.districts;
  }
  return const [];
}

String cityLabel(String? cityValue, String languageCode) {
  if (cityValue == null) return '';
  for (final city in kCities) {
    if (city.value == cityValue) return city.label(languageCode);
  }
  return '';
}

const List<RfqOption> kMoveInOptions = [
  RfqOption(value: 'within_month', labelAr: 'خلال شهر', labelEn: 'Within a Month'),
  RfqOption(value: 'immediate', labelAr: 'فورًا', labelEn: 'Immediately'),
  RfqOption(value: 'within_3_months', labelAr: 'خلال 3 أشهر', labelEn: 'Within 3 Months'),
  RfqOption(value: 'within_6_months', labelAr: 'خلال 6 أشهر', labelEn: 'Within 6 Months'),
];

const List<RfqOption> kContractLengthOptions = [
  RfqOption(value: 'one_year', labelAr: 'سنة', labelEn: '1 Year'),
  RfqOption(value: 'two_years', labelAr: 'سنتان', labelEn: '2 Years'),
  RfqOption(value: 'three_years', labelAr: '3 سنوات', labelEn: '3 Years'),
  RfqOption(value: 'more_than_five_years', labelAr: 'أكثر من 5 سنوات', labelEn: 'More than 5 Years'),
];

const List<RfqOption> kBudgetOptions = [
  RfqOption(value: 'mid', labelAr: '500 ألف - مليون', labelEn: '500K - 1M'),
  RfqOption(value: 'low', labelAr: 'أقل من 500 ألف', labelEn: 'Less than 500K'),
  RfqOption(value: 'high', labelAr: 'أكثر من 3 مليون', labelEn: 'More than 3M'),
  RfqOption(value: 'mid_high', labelAr: '1 - 3 مليون', labelEn: '1M - 3M'),
];

const List<String> _monthsAr = [
  'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
  'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
];
const List<String> _monthsEn = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String formatDate(DateTime date, String languageCode) {
  final months = languageCode == 'ar' ? _monthsAr : _monthsEn;
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

String optionLabel(List<RfqOption> options, String? value, String languageCode) {
  if (value == null) return '';
  for (final option in options) {
    if (option.value == value) return option.label(languageCode);
  }
  return '';
}
