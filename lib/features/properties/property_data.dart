class Property {
  const Property({
    required this.id,
    required this.code,
    required this.typeAr,
    required this.typeEn,
    required this.neighborhoodAr,
    required this.neighborhoodEn,
    required this.areaSqm,
    required this.availableUnits,
    required this.pricePerSqm,
    required this.imageAsset,
    required this.grade,
  });

  final String id;
  final String code;
  final String typeAr;
  final String typeEn;
  final String neighborhoodAr;
  final String neighborhoodEn;
  final double areaSqm;
  final int availableUnits;
  final double pricePerSqm;
  final String imageAsset;
  final String grade;

  double get annualPrice => areaSqm * pricePerSqm;

  String type(String languageCode) => languageCode == 'ar' ? typeAr : typeEn;
  String neighborhood(String languageCode) => languageCode == 'ar' ? neighborhoodAr : neighborhoodEn;
  String title(String languageCode) =>
      languageCode == 'ar' ? '$typeAr رقم $code' : '$typeEn No. $code';
}

String formatMoney(double value) {
  final isNegative = value < 0;
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final intPart = parts[0];
  final buffer = StringBuffer();
  for (var i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write(',');
    buffer.write(intPart[i]);
  }
  return '${isNegative ? '-' : ''}$buffer.${parts[1]}';
}

String formatArea(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toStringAsFixed(2);
}

const List<Property> kProperties = [
  Property(
    id: 'p1',
    code: '1005203',
    typeAr: 'مكتب',
    typeEn: 'Office',
    neighborhoodAr: 'العليا',
    neighborhoodEn: 'Olaya',
    areaSqm: 217,
    availableUnits: 3,
    pricePerSqm: 3428.91,
    imageAsset: 'assets/units/tower-golden-hour.jpg',
    grade: 'A',
  ),
  Property(
    id: 'p2',
    code: '1005237',
    typeAr: 'مركز تجاري',
    typeEn: 'Commercial Center',
    neighborhoodAr: 'طريق الملك فهد',
    neighborhoodEn: 'King Fahd Road',
    areaSqm: 815.25,
    availableUnits: 4,
    pricePerSqm: 4123.81,
    imageAsset: 'assets/units/riyadh-skyline-landscape.jpg',
    grade: 'A',
  ),
  Property(
    id: 'p3',
    code: '1005219',
    typeAr: 'مكاتب مشتركة',
    typeEn: 'Shared Office',
    neighborhoodAr: 'مركز الملك عبدالله المالي',
    neighborhoodEn: 'King Abdullah Financial District',
    areaSqm: 840.75,
    availableUnits: 4,
    pricePerSqm: 3834.33,
    imageAsset: 'assets/units/tower-lobby.jpg',
    grade: 'B',
  ),
  Property(
    id: 'p4',
    code: '1005180',
    typeAr: 'مستودع',
    typeEn: 'Warehouse',
    neighborhoodAr: 'الملقا',
    neighborhoodEn: 'Al Malqa',
    areaSqm: 601,
    availableUnits: 3,
    pricePerSqm: 8837.86,
    imageAsset: 'assets/units/villas-compound.jpg',
    grade: 'A',
  ),
  Property(
    id: 'p5',
    code: '1005220',
    typeAr: 'مكتب',
    typeEn: 'Office',
    neighborhoodAr: 'الياسمين',
    neighborhoodEn: 'Al Yasmin',
    areaSqm: 300,
    availableUnits: 5,
    pricePerSqm: 2100,
    imageAsset: 'assets/units/villa-modern-dusk.jpg',
    grade: 'B',
  ),
  Property(
    id: 'p6',
    code: '1005245',
    typeAr: 'مركز تجاري',
    typeEn: 'Commercial Center',
    neighborhoodAr: 'العليا',
    neighborhoodEn: 'Olaya',
    areaSqm: 950,
    availableUnits: 2,
    pricePerSqm: 3900,
    imageAsset: 'assets/units/palace-aerial.jpg',
    grade: 'A',
  ),
];
