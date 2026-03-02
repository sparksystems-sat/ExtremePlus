import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/app/app_router.dart';
import 'package:exam_practice_app/features/book_mark/book_mark.dart';
import 'package:exam_practice_app/features/home/screens/home_page.dart';
import 'package:exam_practice_app/features/offline/offline.dart';
import 'package:exam_practice_app/features/more/more_page.dart';
import 'package:exam_practice_app/screen/alerts_page.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/app_drawer.dart';

import 'package:animated_background/animated_background.dart';

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  final ParticleOptions _particles = ParticleOptions(
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

  final ParticleOptions _particlesOff = const ParticleOptions(particleCount: 0);

  int _selectedIndex = 0;

  late final List<GlobalKey<NavigatorState>> _navigatorKeys;
  late final List<NavigatorObserver> _navigatorObservers;

  bool _rebuildScheduled = false;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());
    _navigatorObservers = List.generate(
      5,
      (tabIndex) =>
          _TabNavObserver(tabIndex: tabIndex, onChanged: _onTabNavChanged),
    );
  }

  void _onTabNavChanged(int tabIndex) {
    if (!mounted) return;
    if (tabIndex != _selectedIndex) return;
    if (_rebuildScheduled) return;

    _rebuildScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rebuildScheduled = false;
      if (!mounted) return;
      setState(() {});
    });
  }

  bool _isTabRoot(int tabIndex) {
    return !(_navigatorKeys[tabIndex].currentState?.canPop() ?? false);
  }

  void _popTabToRoot(int tabIndex) {
    final nav = _navigatorKeys[tabIndex].currentState;
    if (nav == null) return;
    nav.popUntil((route) => route.isFirst);
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      _popTabToRoot(index);
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    _popTabToRoot(index);
  }

  Route<dynamic> _onGenerateTabRoute(int tabIndex, RouteSettings settings) {
    if (settings.name == Navigator.defaultRouteName) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (tabIndex) {
            case 0:
              return const HomePage();
            case 1:
              return const BookMarkPage();
            case 2:
              return const OfflinePage();
            case 3:
              return const MorePage();
            case 4:
              return const AlertsPage();
            default:
              return const HomePage();
          }
        },
      );
    }

    return AppRouter.onGenerateRoute(settings);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <_NavTabConfig>[
      _NavTabConfig(
        label: t(context).bottom_home,
        activeIcon: Icons.home,
        inactiveIcon: Icons.home_outlined,
      ),
      _NavTabConfig(
        label: t(context).bottom_book_mark,
        activeIcon: Icons.bookmark,
        inactiveIcon: Icons.bookmark_border,
      ),
      _NavTabConfig(
        label: t(context).bottom_offline,
        activeIcon: Icons.wifi_off,
        inactiveIcon: Icons.wifi_off_outlined,
      ),
      const _NavTabConfig(
        label: 'More',
        activeIcon: Icons.more_vert,
        inactiveIcon: Icons.more_vert,
      ),
      const _NavTabConfig(
        label: 'Alerts',
        activeIcon: Icons.notifications,
        inactiveIcon: Icons.notifications_none,
      ),
    ];

    final currentNav = _navigatorKeys[_selectedIndex].currentState;
    final allowSystemPop =
        (currentNav == null || !currentNav.canPop())
            ? _selectedIndex == 0
            : false;

    final isRoot = _isTabRoot(_selectedIndex);

    final content = IndexedStack(
      index: _selectedIndex,
      children: List.generate(tabs.length, (i) {
        return Navigator(
          key: _navigatorKeys[i],
          observers: [_navigatorObservers[i]],
          onGenerateRoute: (settings) => _onGenerateTabRoute(i, settings),
        );
      }),
    );

    return PopScope(
      canPop: allowSystemPop,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        final nav = _navigatorKeys[_selectedIndex].currentState;
        if (nav != null && nav.canPop()) {
          nav.pop();
          return;
        }

        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar:
            (_selectedIndex == 0 && isRoot)
                ? AppBar(
                  backgroundColor: AppColors.main_background_color,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Divider(height: 1, thickness: 1),
                  ),
                  leadingWidth: 64,
                  leading: Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(
                            'assets/svgs/profile.jpeg',
                          ),
                        ),
                      );
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help_outline,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.sync, color: Colors.black87),
                    ),
                    const SizedBox(width: 4),
                  ],
                )
                : null,
        body: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
            options: isRoot ? _particles : _particlesOff,
            paint:
                Paint()
                  ..strokeWidth = 10.0
                  ..style = PaintingStyle.stroke,
          ),
          child: SafeArea(child: content),
        ),
        bottomNavigationBar: _BottomNavBar(
          tabs: tabs,
          selectedIndex: _selectedIndex,
          showSelectedBackground: isRoot,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class _NavTabConfig {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const _NavTabConfig({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}

class _TabNavObserver extends NavigatorObserver {
  _TabNavObserver({required this.tabIndex, required this.onChanged});

  final int tabIndex;
  final void Function(int tabIndex) onChanged;

  void _notify() => onChanged(tabIndex);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _notify();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _notify();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _notify();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _notify();
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.tabs,
    required this.selectedIndex,
    required this.showSelectedBackground,
    required this.onTap,
  });

  static const double _barHeight = 60;

  final List<_NavTabConfig> tabs;
  final int selectedIndex;
  final bool showSelectedBackground;
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final tab = tabs[i];
              final active = i == selectedIndex;
              final showBg = active && showSelectedBackground;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () => onTap(i),
                    child: SizedBox(
                      height: _barHeight,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: showBg ? selectedBg : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow:
                                    showBg
                                        ? [
                                          BoxShadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 8,
                                            color: Colors.black.withValues(
                                              alpha: 0.12,
                                            ),
                                          ),
                                        ]
                                        : [],
                              ),
                              child: Icon(
                                active ? tab.activeIcon : tab.inactiveIcon,
                                color: fg,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  tab.label,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: fg,
                                    fontSize: 13,
                                    fontWeight:
                                        active
                                            ? FontWeight.w800
                                            : FontWeight.w500,
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
        ),
      ),
    );
  }
}
