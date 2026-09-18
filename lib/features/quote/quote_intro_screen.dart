import 'package:flutter/material.dart';

import '../../core/localization/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../rfq/rfq_wizard_screen.dart';
import 'quote_data.dart';

class QuoteIntroScreen extends StatelessWidget {
  const QuoteIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final colors = AppColors.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: colors.isDark ? colors.background : kWhite,
              borderRadius: BorderRadius.circular(28),
              border: colors.isDark ? null : Border.all(color: colors.border),
              boxShadow: colors.isDark
                  ? null
                  : [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: colors.chip,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.of(context).pop(),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.close, color: colors.textPrimary, size: 18),
                        ),
                      ),
                    ),
                    Text(
                      strings.quoteLabel,
                      style: const TextStyle(color: kGold, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  strings.quoteTitle,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.quoteDesc,
                  style: TextStyle(color: colors.textSecondary, fontSize: 15, height: 1.6),
                ),
                const SizedBox(height: 28),
                for (var i = 0; i < kQuoteSteps.length; i++) ...[
                  _QuoteStepRow(index: i + 1, label: kQuoteSteps[i].label(languageCode), colors: colors),
                  if (i != kQuoteSteps.length - 1) const SizedBox(height: 14),
                ],
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RfqWizardScreen()),
                    ),
                    icon: Icon(nextIcon(context), size: 18),
                    label: Text(strings.startRequest),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuoteStepRow extends StatelessWidget {
  const _QuoteStepRow({required this.index, required this.label, required this.colors});

  final int index;
  final String label;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: kGold,
            child: Text(
              '$index',
              style: const TextStyle(color: kBlack, fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: TextStyle(color: colors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
