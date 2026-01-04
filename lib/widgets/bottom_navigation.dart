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

  BottomNavigationBarItem _item({
    required int index,
    required Widget icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: _NavTab(icon: icon, label: label, active: _selectedIndex == index),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          items: [
            _item(
              index: 0,
              icon: const FaIcon(FontAwesomeIcons.house),
              label: t(context).bottom_home,
            ),
            _item(
              index: 1,
              icon: const FaIcon(FontAwesomeIcons.solidBookmark),
              label: t(context).bottom_book_mark,
            ),
            _item(
              index: 2,
              icon: const Icon(Icons.wifi_off),
              label: t(context).bottom_offline,
            ),
            _item(
              index: 3,
              icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
        ),
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

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.label,
    required this.active,
  });

  final Widget icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final Color fg =
        active
            ? AppColors.navSelectedForeground
            : AppColors.navSelectedForeground;

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(data: IconThemeData(color: fg, size: 22), child: icon),
        const SizedBox(height: 4),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: fg,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    if (!active) return content;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.navSelectedBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: content,
    );
  }
}
