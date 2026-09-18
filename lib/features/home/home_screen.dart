import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/app_strings.dart';
import '../../core/settings/settings_controller.dart';
import '../../core/theme/app_theme.dart';
import '../explore/explore_screen.dart';
import '../properties/property_data.dart';
import '../quote/quote_intro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 4;
  final Set<String> _matchedIds = {};

  void _toggleMatch(String id) {
    setState(() {
      if (_matchedIds.contains(id)) {
        _matchedIds.remove(id);
      } else {
        _matchedIds.add(id);
      }
    });
  }

  void _openQuoteIntro() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuoteIntroScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final strings = AppStrings.of(context);
    final languageCode = settings.locale.languageCode;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final tabs = [
      _ComingSoonTab(strings: strings, icon: Icons.person_outline),
      _MatchesTab(strings: strings, languageCode: languageCode, matchedIds: _matchedIds, onToggleMatch: _toggleMatch),
      const SizedBox.shrink(),
      _ComingSoonTab(strings: strings, icon: Icons.map_outlined),
      ExploreScreen(matchedIds: _matchedIds, onToggleMatch: _toggleMatch),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.brand, style: const TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: strings.themeTooltip,
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => context.read<SettingsController>().toggleTheme(),
          ),
          IconButton(
            tooltip: strings.languageTooltip,
            icon: Text(
              languageCode == 'ar' ? 'EN' : 'AR',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            onPressed: () => context.read<SettingsController>().toggleLocale(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: IndexedStack(index: _tabIndex, children: tabs)),
      bottomNavigationBar: _BottomBar(
        strings: strings,
        currentIndex: _tabIndex,
        matchCount: _matchedIds.length,
        onSelect: (i) {
          if (i == 2) {
            _openQuoteIntro();
            return;
          }
          setState(() => _tabIndex = i);
        },
      ),
    );
  }
}

class _MatchesTab extends StatelessWidget {
  const _MatchesTab({
    required this.strings,
    required this.languageCode,
    required this.matchedIds,
    required this.onToggleMatch,
  });

  final AppStrings strings;
  final String languageCode;
  final Set<String> matchedIds;
  final ValueChanged<String> onToggleMatch;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final selected = kProperties.where((p) => matchedIds.contains(p.id)).toList();

    if (selected.isEmpty) {
      return Center(
        child: Text(strings.noMatchesYet, style: TextStyle(color: colors.textTertiary)),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        for (final property in selected)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: colors.border),
              ),
              title: Text(property.title(languageCode), textAlign: TextAlign.end),
              subtitle: Text(property.neighborhood(languageCode), textAlign: TextAlign.end),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: kGold, size: 20),
                onPressed: () => onToggleMatch(property.id),
              ),
            ),
          ),
      ],
    );
  }
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.strings, required this.icon});

  final AppStrings strings;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: colors.textFaint),
          const SizedBox(height: 12),
          Text(strings.comingSoon, style: TextStyle(color: colors.textTertiary)),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.strings,
    required this.currentIndex,
    required this.matchCount,
    required this.onSelect,
  });

  final AppStrings strings;
  final int currentIndex;
  final int matchCount;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore,
              label: strings.exploreTab,
              active: currentIndex == 4,
              colors: colors,
              onTap: () => onSelect(4),
            ),
            _NavItem(
              icon: Icons.map_outlined,
              activeIcon: Icons.map,
              label: strings.mapTab,
              active: currentIndex == 3,
              colors: colors,
              onTap: () => onSelect(3),
            ),
            _CenterNavItem(label: strings.requestTab, onTap: () => onSelect(2)),
            _NavItem(
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite,
              label: strings.matches,
              active: currentIndex == 1,
              colors: colors,
              badgeCount: matchCount,
              onTap: () => onSelect(1),
            ),
            _NavItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: strings.account,
              active: currentIndex == 0,
              colors: colors,
              onTap: () => onSelect(0),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.colors,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final AppColors colors;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final color = active ? kGold : colors.textTertiary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(active ? activeIcon : icon, color: color, size: 24),
                if (badgeCount > 0)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: kBlack, fontSize: 9, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  const _CenterNavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, -10),
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: kBlack,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: const Icon(Icons.add, color: kWhite, size: 26),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -6),
              child: Text(label, style: TextStyle(color: colors.textTertiary, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }
}
