import 'package:flutter/material.dart';

import '../../core/localization/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../properties/property_data.dart';
import '../quote/quote_intro_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({
    super.key,
    required this.matchedIds,
    required this.onToggleMatch,
  });

  final Set<String> matchedIds;
  final ValueChanged<String> onToggleMatch;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          strings.welcomeTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(strings.welcomeBody, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 20),
        _RfqBanner(
          strings: strings,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const QuoteIntroScreen()),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          strings.availableProperties,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        for (final property in kProperties) ...[
          _PropertyCard(
            property: property,
            languageCode: languageCode,
            strings: strings,
            matched: matchedIds.contains(property.id),
            onToggleMatch: () => onToggleMatch(property.id),
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _RfqBanner extends StatelessWidget {
  const _RfqBanner({required this.strings, required this.onTap});

  final AppStrings strings;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      color: colors.background,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: colors.isDark ? null : Border.all(color: colors.border),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                strings.quoteLabel,
                style: const TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                strings.quoteTitle,
                textAlign: TextAlign.end,
                style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                strings.quoteDesc,
                textAlign: TextAlign.end,
                style: TextStyle(color: colors.textSecondary, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onTap,
                  icon: Icon(nextIcon(context), size: 18),
                  label: Text(strings.quoteLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({
    required this.property,
    required this.languageCode,
    required this.strings,
    required this.matched,
    required this.onToggleMatch,
  });

  final Property property;
  final String languageCode;
  final AppStrings strings;
  final bool matched;
  final VoidCallback onToggleMatch;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PropertyPhoto(
            imageAsset: property.imageAsset,
            grade: property.grade,
            matched: matched,
            matchTooltip: strings.matches,
            onToggleMatch: onToggleMatch,
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  property.title(languageCode),
                  textAlign: TextAlign.end,
                  style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      property.neighborhood(languageCode),
                      style: TextStyle(color: colors.textTertiary, fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.location_on_outlined, size: 14, color: colors.textTertiary),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        colors: colors,
                        label: strings.areaLabel,
                        value: '${formatArea(property.areaSqm)} ${strings.sqmShort}',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatBox(
                        colors: colors,
                        label: strings.availableUnitsLabel,
                        value: '${property.availableUnits}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(strings.annuallyLabel, style: TextStyle(color: colors.textTertiary, fontSize: 11)),
                        const SizedBox(height: 2),
                        Text(
                          '${formatMoney(property.annualPrice)} SAR',
                          style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(strings.startingFromLabel, style: TextStyle(color: colors.textTertiary, fontSize: 11)),
                        const SizedBox(height: 2),
                        Text(
                          '${formatMoney(property.pricePerSqm)} SAR${strings.perSqmSuffix}',
                          style: const TextStyle(color: kGold, fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyPhoto extends StatelessWidget {
  const _PropertyPhoto({
    required this.imageAsset,
    required this.grade,
    required this.matched,
    required this.matchTooltip,
    required this.onToggleMatch,
  });

  final String imageAsset;
  final String grade;
  final bool matched;
  final String matchTooltip;
  final VoidCallback onToggleMatch;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imageAsset, fit: BoxFit.cover, cacheWidth: 800),
          PositionedDirectional(
            top: 10,
            start: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '+$grade',
                style: const TextStyle(color: kWhite, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          PositionedDirectional(
            top: 10,
            end: 10,
            child: Tooltip(
              message: matchTooltip,
              child: Material(
                color: Colors.black.withValues(alpha: 0.4),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onToggleMatch,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      matched ? Icons.favorite : Icons.favorite_border,
                      color: matched ? kGold : kWhite,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.colors, required this.label, required this.value});

  final AppColors colors;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: colors.textTertiary, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
        ],
      ),
    );
  }
}
