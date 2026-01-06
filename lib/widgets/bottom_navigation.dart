import 'package:animated_background/animated_background.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/screen/book_mark.dart';
import 'package:exam_practice_app/screen/home.dart';
import 'package:exam_practice_app/screen/offline.dart';
import 'package:exam_practice_app/screen/more_page.dart';
import 'package:exam_practice_app/widgets/app_bar.dart';
import 'package:exam_practice_app/utility/appColors.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  ParticleOptions particles = ParticleOptions(
    baseColor: Colors.red,
    spawnOpacity: 0.1,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 30,
  );
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookMarkPage(),
    OfflinePage(),
    MorePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <_NavItems>[
      _NavItems(
        icon: const FaIcon(FontAwesomeIcons.house),
        label: t(context).bottom_home,
      ),
      _NavItems(
        icon: const FaIcon(FontAwesomeIcons.solidBookmark),
        label: t(context).bottom_book_mark,
      ),
      _NavItems(
        icon: const Icon(Icons.wifi_off),
        label: t(context).bottom_offline,
      ),
      const _NavItems(
        icon: FaIcon(FontAwesomeIcons.ellipsisVertical),
        label: 'More',
      ),
    ];

    return Scaffold(
      bottomNavigationBar: _BottomNavBar(
        items: items,
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: particles,
          paint:
              Paint()
                ..strokeWidth = 10.0
                ..style = PaintingStyle.stroke,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              App_Bar(),
              SliverFillRemaining(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItems {
  final Widget icon;
  final String label;

  const _NavItems({required this.icon, required this.label});
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  static const double _barHeight = 79;
  static const double _selectedHeight = 92;

  final List<_NavItems> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bg = Colors.white;
    final selectedBg = AppColors.navSelectedBackground;
    final fg = AppColors.navSelectedForeground;

    return SafeArea(
      top: false,
      child: Container(
        height: _barHeight,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemCount = items.length;
              final itemWidth = constraints.maxWidth / itemCount;
              final highlightLeft = itemWidth * selectedIndex;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: highlightLeft,
                    bottom: 0,
                    width: itemWidth,
                    height: _selectedHeight,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: selectedBg,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(itemCount, (i) {
                      final d = items[i];
                      final active = i == selectedIndex;

                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => onTap(i),
                            child: SizedBox(
                              height: _barHeight,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(color: fg, size: 25),
                                      child: d.icon,
                                    ),
                                    const SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          d.label,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            color: fg,
                                            fontSize: 14,
                                            fontWeight:
                                                active
                                                    ? FontWeight.w700
                                                    : FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
