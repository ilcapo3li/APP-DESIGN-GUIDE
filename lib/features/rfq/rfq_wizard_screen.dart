import 'package:flutter/material.dart';

import '../../core/localization/app_strings.dart';
import '../../core/theme/app_theme.dart';
import 'rfq_options.dart';

const int kRfqStepCount = 5;

class RfqWizardScreen extends StatefulWidget {
  const RfqWizardScreen({super.key});

  @override
  State<RfqWizardScreen> createState() => _RfqWizardScreenState();
}

class _RfqWizardScreenState extends State<RfqWizardScreen> {
  int _currentStep = 0;
  bool _submitted = false;

  String? _propertyType;
  double _area = 600;
  String? _city;
  final Set<String> _locations = {};
  String? _moveIn;
  DateTime? _moveInDate;
  String? _contractLength;
  String? _budget;

  bool get _canContinue {
    switch (_currentStep) {
      case 0:
        return _propertyType != null;
      case 1:
        return _city != null && _locations.isNotEmpty;
      case 2:
        return _contractLength != null;
      case 3:
        return _budget != null;
      default:
        return true;
    }
  }

  void _goBack() {
    if (_currentStep == 0) return;
    setState(() => _currentStep -= 1);
  }

  void _goNext() {
    if (!_canContinue) return;
    if (_currentStep == kRfqStepCount - 1) {
      setState(() => _submitted = true);
    } else {
      setState(() => _currentStep += 1);
    }
  }

  void _toggleLocation(String value) {
    setState(() {
      if (_locations.contains(value)) {
        _locations.remove(value);
      } else {
        _locations.add(value);
      }
    });
  }

  void _setCity(String value) {
    if (_city == value) return;
    setState(() {
      _city = value;
      _locations.clear();
    });
  }

  Future<void> _pickMoveInDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _moveInDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 730)),
    );
    if (picked != null) {
      setState(() => _moveInDate = picked);
    }
  }

  void _clearMoveInDate() {
    setState(() => _moveInDate = null);
  }

  void _backToHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _confirmCancel() async {
    final strings = AppStrings.of(context);
    final colors = AppColors.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.isDark ? kNavy : kWhite,
        title: Text(strings.cancelRequestTitle, style: TextStyle(color: colors.textPrimary)),
        content: Text(strings.cancelRequestBody, style: TextStyle(color: colors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(strings.cancelRequestDismiss, style: TextStyle(color: colors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(strings.cancelRequestConfirm, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      _backToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              _TopBar(strings: strings, colors: colors, onClose: _confirmCancel),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: _submitted
                      ? _SuccessBody(strings: strings, colors: colors, onBackToHome: _backToHome)
                      : _StepBody(
                          strings: strings,
                          colors: colors,
                          currentStep: _currentStep,
                          propertyType: _propertyType,
                          area: _area,
                          city: _city,
                          locations: _locations,
                          moveIn: _moveIn,
                          moveInDate: _moveInDate,
                          contractLength: _contractLength,
                          budget: _budget,
                          onPropertyType: (v) => setState(() => _propertyType = v),
                          onArea: (v) => setState(() => _area = v),
                          onCity: _setCity,
                          onToggleLocation: _toggleLocation,
                          onMoveIn: (v) => setState(() => _moveIn = v),
                          onPickMoveInDate: _pickMoveInDate,
                          onClearMoveInDate: _clearMoveInDate,
                          onContractLength: (v) => setState(() => _contractLength = v),
                          onBudget: (v) => setState(() => _budget = v),
                        ),
                ),
              ),
              if (!_submitted) ...[
                if (!_canContinue && _currentStep == 3)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      strings.chooseBudgetToContinue,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: colors.textFaint, fontSize: 13),
                    ),
                  ),
                Row(
                  children: [
                    if (_currentStep > 0) ...[
                      _SquareIconButton(icon: previousIcon(context), colors: colors, onTap: _goBack),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _canContinue ? _goNext : null,
                        icon: Icon(nextIcon(context), size: 18),
                        label: Text(
                          _currentStep == kRfqStepCount - 1
                              ? strings.submitRequest
                              : strings.continueLabel,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.strings, required this.colors, required this.onClose});

  final AppStrings strings;
  final AppColors colors;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SquareIconButton(icon: Icons.close, colors: colors, onTap: onClose),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  strings.brand,
                  style: TextStyle(color: colors.textPrimary, fontSize: 17, fontWeight: FontWeight.w700),
                ),
                Text(
                  strings.rfqTagline,
                  style: TextStyle(color: colors.textTertiary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: kGold, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.apartment, color: kBlack),
            ),
          ],
        ),
      ],
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.icon, required this.colors, required this.onTap});

  final IconData icon;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.chip,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(width: 44, height: 44, child: Icon(icon, color: colors.textPrimary, size: 20)),
      ),
    );
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({
    required this.strings,
    required this.colors,
    required this.currentStep,
    required this.propertyType,
    required this.area,
    required this.city,
    required this.locations,
    required this.moveIn,
    required this.moveInDate,
    required this.contractLength,
    required this.budget,
    required this.onPropertyType,
    required this.onArea,
    required this.onCity,
    required this.onToggleLocation,
    required this.onMoveIn,
    required this.onPickMoveInDate,
    required this.onClearMoveInDate,
    required this.onContractLength,
    required this.onBudget,
  });

  final AppStrings strings;
  final AppColors colors;
  final int currentStep;
  final String? propertyType;
  final double area;
  final String? city;
  final Set<String> locations;
  final String? moveIn;
  final DateTime? moveInDate;
  final String? contractLength;
  final String? budget;
  final ValueChanged<String> onPropertyType;
  final ValueChanged<double> onArea;
  final ValueChanged<String> onCity;
  final ValueChanged<String> onToggleLocation;
  final ValueChanged<String> onMoveIn;
  final VoidCallback onPickMoveInDate;
  final VoidCallback onClearMoveInDate;
  final ValueChanged<String> onContractLength;
  final ValueChanged<String> onBudget;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              strings.quoteLabel,
              style: const TextStyle(color: kGold, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              '$kRfqStepCount / ${currentStep + 1}',
              style: TextStyle(color: colors.textTertiary, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          strings.rfqHeadline,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 28, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        _ProgressBar(currentStep: currentStep, colors: colors),
        const SizedBox(height: 28),
        switch (currentStep) {
          0 => _PropertyStep(
              strings: strings,
              colors: colors,
              languageCode: languageCode,
              selected: propertyType,
              area: area,
              onSelected: onPropertyType,
              onArea: onArea,
            ),
          1 => _LocationStep(
              strings: strings,
              colors: colors,
              languageCode: languageCode,
              city: city,
              locations: locations,
              onCity: onCity,
              onToggleLocation: onToggleLocation,
            ),
          2 => _DateContractStep(
              strings: strings,
              colors: colors,
              languageCode: languageCode,
              moveIn: moveIn,
              moveInDate: moveInDate,
              contractLength: contractLength,
              onMoveIn: onMoveIn,
              onPickMoveInDate: onPickMoveInDate,
              onClearMoveInDate: onClearMoveInDate,
              onContractLength: onContractLength,
            ),
          3 => _OptionGridStep(
              question: strings.step4Question,
              options: kBudgetOptions,
              colors: colors,
              languageCode: languageCode,
              isSelected: (v) => v == budget,
              onSelected: onBudget,
            ),
          _ => _ReviewStep(
              strings: strings,
              colors: colors,
              languageCode: languageCode,
              propertyType: propertyType,
              area: area,
              city: city,
              locations: locations,
              moveIn: moveIn,
              moveInDate: moveInDate,
              contractLength: contractLength,
              budget: budget,
            ),
        },
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.currentStep, required this.colors});

  final int currentStep;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(kRfqStepCount, (i) {
        final filled = i <= currentStep;
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: i == kRfqStepCount - 1 ? 0 : 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 4,
              decoration: BoxDecoration(
                color: filled ? kGold : colors.track,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? kGold : colors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected ? kBlack : colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 6),
                const Icon(Icons.check, color: kBlack, size: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionGrid extends StatelessWidget {
  const _OptionGrid({
    required this.options,
    required this.languageCode,
    required this.colors,
    required this.isSelected,
    required this.onSelected,
  });

  final List<RfqOption> options;
  final String languageCode;
  final AppColors colors;
  final bool Function(String value) isSelected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, i) {
        final option = options[i];
        return _OptionTile(
          label: option.label(languageCode),
          selected: isSelected(option.value),
          colors: colors,
          onTap: () => onSelected(option.value),
        );
      },
    );
  }
}

class _OptionGridStep extends StatelessWidget {
  const _OptionGridStep({
    required this.question,
    required this.options,
    required this.colors,
    required this.languageCode,
    required this.isSelected,
    required this.onSelected,
  });

  final String question;
  final List<RfqOption> options;
  final AppColors colors;
  final String languageCode;
  final bool Function(String value) isSelected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        _OptionGrid(
          options: options,
          languageCode: languageCode,
          colors: colors,
          isSelected: isSelected,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class _LocationStep extends StatelessWidget {
  const _LocationStep({
    required this.strings,
    required this.colors,
    required this.languageCode,
    required this.city,
    required this.locations,
    required this.onCity,
    required this.onToggleLocation,
  });

  final AppStrings strings;
  final AppColors colors;
  final String languageCode;
  final String? city;
  final Set<String> locations;
  final ValueChanged<String> onCity;
  final ValueChanged<String> onToggleLocation;

  @override
  Widget build(BuildContext context) {
    final districts = districtsForCity(city);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.step2Question,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Text(
          strings.cityLabel,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: city,
              isExpanded: true,
              alignment: AlignmentDirectional.centerEnd,
              hint: Text(
                strings.chooseCityHint,
                textAlign: TextAlign.end,
                style: TextStyle(color: colors.textTertiary, fontSize: 14),
              ),
              dropdownColor: colors.isDark ? kNavy : kWhite,
              icon: Icon(Icons.keyboard_arrow_down, color: colors.textSecondary),
              items: kCities
                  .map(
                    (c) => DropdownMenuItem(
                      value: c.value,
                      child: Text(
                        c.label(languageCode),
                        textAlign: TextAlign.end,
                        style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) onCity(value);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          strings.districtsLabel,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 10),
        if (districts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              strings.chooseCityFirst,
              textAlign: TextAlign.end,
              style: TextStyle(color: colors.textFaint, fontSize: 13),
            ),
          )
        else
          _OptionGrid(
            options: districts,
            languageCode: languageCode,
            colors: colors,
            isSelected: locations.contains,
            onSelected: onToggleLocation,
          ),
      ],
    );
  }
}

class _PropertyStep extends StatelessWidget {
  const _PropertyStep({
    required this.strings,
    required this.colors,
    required this.languageCode,
    required this.selected,
    required this.area,
    required this.onSelected,
    required this.onArea,
  });

  final AppStrings strings;
  final AppColors colors;
  final String languageCode;
  final String? selected;
  final double area;
  final ValueChanged<String> onSelected;
  final ValueChanged<double> onArea;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.step1Question,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        _OptionGrid(
          options: kPropertyTypeOptions,
          languageCode: languageCode,
          colors: colors,
          isSelected: (v) => v == selected,
          onSelected: onSelected,
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${area.round()} ${strings.sqmShort}',
              style: const TextStyle(color: kGold, fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              strings.requiredArea,
              style: TextStyle(color: colors.textSecondary, fontSize: 14),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: kGold,
            inactiveTrackColor: colors.track,
            thumbColor: kGold,
            overlayColor: kGold.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: area,
            min: 100,
            max: 1000,
            onChanged: onArea,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('100 ${strings.sqmShort}', style: TextStyle(color: colors.textFaint, fontSize: 12)),
            Text('1000 ${strings.sqmShort}', style: TextStyle(color: colors.textFaint, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class _DateContractStep extends StatelessWidget {
  const _DateContractStep({
    required this.strings,
    required this.colors,
    required this.languageCode,
    required this.moveIn,
    required this.moveInDate,
    required this.contractLength,
    required this.onMoveIn,
    required this.onPickMoveInDate,
    required this.onClearMoveInDate,
    required this.onContractLength,
  });

  final AppStrings strings;
  final AppColors colors;
  final String languageCode;
  final String? moveIn;
  final DateTime? moveInDate;
  final String? contractLength;
  final ValueChanged<String> onMoveIn;
  final VoidCallback onPickMoveInDate;
  final VoidCallback onClearMoveInDate;
  final ValueChanged<String> onContractLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.step3Question,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Text(
          strings.moveInDate,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 10),
        _OptionGrid(
          options: kMoveInOptions,
          languageCode: languageCode,
          colors: colors,
          isSelected: (v) => v == moveIn,
          onSelected: onMoveIn,
        ),
        const SizedBox(height: 12),
        if (moveInDate != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                TextButton(
                  onPressed: onClearMoveInDate,
                  child: Text(strings.clearDate),
                ),
                TextButton(
                  onPressed: onPickMoveInDate,
                  child: Text(strings.changeDate),
                ),
                const Spacer(),
                const Icon(Icons.event, size: 16, color: kGold),
                const SizedBox(width: 6),
                Text(
                  formatDate(moveInDate!, languageCode),
                  style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ],
            ),
          )
        else
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: onPickMoveInDate,
              icon: const Icon(Icons.event, size: 16, color: kGold),
              label: Text(
                strings.orPickSpecificDate,
                style: const TextStyle(color: kGold, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Text(
          strings.contractLength,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 10),
        _OptionGrid(
          options: kContractLengthOptions,
          languageCode: languageCode,
          colors: colors,
          isSelected: (v) => v == contractLength,
          onSelected: onContractLength,
        ),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    required this.strings,
    required this.colors,
    required this.languageCode,
    required this.propertyType,
    required this.area,
    required this.city,
    required this.locations,
    required this.moveIn,
    required this.moveInDate,
    required this.contractLength,
    required this.budget,
  });

  final AppStrings strings;
  final AppColors colors;
  final String languageCode;
  final String? propertyType;
  final double area;
  final String? city;
  final Set<String> locations;
  final String? moveIn;
  final DateTime? moveInDate;
  final String? contractLength;
  final String? budget;

  @override
  Widget build(BuildContext context) {
    final propertyLabel = optionLabel(kPropertyTypeOptions, propertyType, languageCode);
    final districtLabels = districtsForCity(city)
        .where((o) => locations.contains(o.value))
        .map((o) => o.label(languageCode))
        .join(languageCode == 'ar' ? '، ' : ', ');
    final locationValue = city == null
        ? ''
        : districtLabels.isEmpty
            ? cityLabel(city, languageCode)
            : '${cityLabel(city, languageCode)} - $districtLabels';
    final moveInValue = moveInDate != null
        ? formatDate(moveInDate!, languageCode)
        : (moveIn != null ? optionLabel(kMoveInOptions, moveIn, languageCode) : strings.notSpecified);
    final contractLabel = optionLabel(kContractLengthOptions, contractLength, languageCode);
    final budgetLabel = optionLabel(kBudgetOptions, budget, languageCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          strings.reviewTitle,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          strings.reviewDesc,
          textAlign: TextAlign.end,
          style: TextStyle(color: colors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 20),
        _ReviewRow(
          colors: colors,
          label: strings.propertyTypeLabel,
          value: '$propertyLabel ${area.round()} ${strings.sqmShort}',
        ),
        const SizedBox(height: 10),
        _ReviewRow(colors: colors, label: strings.preferredLocationLabel, value: locationValue),
        const SizedBox(height: 10),
        _ReviewRow(colors: colors, label: strings.moveInAndContractLabel, value: '$moveInValue - $contractLabel'),
        const SizedBox(height: 10),
        _ReviewRow(colors: colors, label: strings.annualBudgetLabel, value: budgetLabel),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.colors, required this.label, required this.value});

  final AppColors colors;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.start,
              style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: colors.textTertiary, fontSize: 13)),
        ],
      ),
    );
  }
}

class _SuccessBody extends StatelessWidget {
  const _SuccessBody({required this.strings, required this.colors, required this.onBackToHome});

  final AppStrings strings;
  final AppColors colors;
  final VoidCallback onBackToHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: kBlack, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            strings.successBadge,
            style: const TextStyle(color: kGold, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            strings.successTitle,
            style: TextStyle(color: colors.textPrimary, fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            strings.successDesc,
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.textSecondary, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onBackToHome,
              child: Text(strings.backToHome),
            ),
          ),
        ],
      ),
    );
  }
}
