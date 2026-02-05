import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:exam_practice_app/features/profile/screens/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey _drawerKey = GlobalKey();

  String _selectedField = 'Social';
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Light';
  String _selectedFontSize = 'Medium (default)';

  Future<void> _openProfile() async {
    Navigator.of(context).pop();
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const UserProfilePage()));
  }

  Future<void> _showAnchoredMenu({
    required BuildContext tileContext,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
    bool highlightSelected = false,
  }) async {
    final overlay =
        Overlay.of(tileContext).context.findRenderObject() as RenderBox;
    final box = tileContext.findRenderObject() as RenderBox;

    final drawerBox =
        _drawerKey.currentContext?.findRenderObject() as RenderBox?;

    final topLeft = box.localToGlobal(Offset.zero, ancestor: overlay);
    final bottomRight = box.localToGlobal(
      box.size.bottomRight(Offset.zero),
      ancestor: overlay,
    );

    final drawerTopLeft = drawerBox?.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );
    final drawerRight =
        drawerTopLeft != null && drawerBox != null
            ? drawerTopLeft.dx + drawerBox.size.width
            : bottomRight.dx;

    final menuLeft = (drawerRight + 12).clamp(8.0, overlay.size.width - 8.0);

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        Offset(menuLeft, topLeft.dy),
        Offset(menuLeft + 1, bottomRight.dy),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<String>(
      context: tileContext,
      position: position,
      items: [
        for (var i = 0; i < options.length; i++) ...[
          PopupMenuItem<String>(
            value: options[i],
            padding: EdgeInsets.zero,
            child: Builder(
              builder: (context) {
                final active = options[i] == selected;

                final showBg = highlightSelected && active;

                return SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration:
                        showBg
                            ? BoxDecoration(color: AppColors.button3Color)
                            : null,
                    child: Text(
                      options[i],
                      style: TextStyle(
                        color: showBg ? Colors.white : Colors.black,
                        fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (i != options.length - 1) const PopupMenuDivider(height: 1),
        ],
      ],
    );

    if (!mounted || result == null) return;
    onSelected(result);
  }

  Future<void> _openChangeFieldMenu(BuildContext tileContext) async {
    await _showAnchoredMenu(
      tileContext: tileContext,
      options: const ['Social', 'Natural'],
      selected: _selectedField,
      onSelected: (v) => setState(() => _selectedField = v),
      highlightSelected: false,
    );
  }

  Future<void> _openLanguageMenu(BuildContext tileContext) async {
    await _showAnchoredMenu(
      tileContext: tileContext,
      options: const [
        'English',
        'Amharic',
        'Tigrinya',
        'Afan Oromo',
        'Other...',
      ],
      selected: _selectedLanguage,
      onSelected: (v) => setState(() => _selectedLanguage = v),
      highlightSelected: true,
    );
  }

  Future<void> _openAppearanceDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: SizedBox(
            width: 280,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Theme',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.18),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 236),
                      child: DropdownButtonFormField<String>(
                        value: _selectedTheme,
                        icon: Transform.rotate(
                          angle: -math.pi / 2,
                          child: const Icon(Icons.chevron_left),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Light',
                            child: Text('Light'),
                          ),
                          DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedTheme = v);
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    indent: 8,
                    endIndent: 8,
                    height: 18,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Font Size',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 236),
                      child: DropdownButtonFormField<String>(
                        value: _selectedFontSize,
                        icon: Transform.rotate(
                          angle: -math.pi / 2,
                          child: const Icon(Icons.chevron_left),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Small',
                            child: Text('Small'),
                          ),
                          DropdownMenuItem(
                            value: 'Medium (default)',
                            child: Text('Medium (default)'),
                          ),
                          DropdownMenuItem(
                            value: 'Large',
                            child: Text('Large'),
                          ),
                        ],
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedFontSize = v);
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _drawerKey,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage('assets/svgs/profile.jpeg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Meklit Alebachew',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Grade 11',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerItem(
                    leading: const Icon(
                      Icons.person_outline,
                      color: Colors.black87,
                    ),
                    title: 'Profile',
                    onTap: (_) => _openProfile(),
                  ),
                  _DrawerItem(
                    leading: SvgPicture.asset(
                      'assets/svgs/change.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Change Field',
                    onTap: _openChangeFieldMenu,
                  ),
                  _DrawerItem(
                    leading: const Icon(Icons.language, color: Colors.black87),
                    title: 'Language',
                    onTap: _openLanguageMenu,
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.color_lens_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Appearance',
                    onTap: (_) => _openAppearanceDialog(),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.leaderboard_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Leaderboard',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.star_border,
                      color: Colors.black87,
                    ),
                    title: 'Achievements',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.settings_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Settings',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: SvgPicture.asset(
                      'assets/svgs/contact_support.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Contact Support',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.feedback_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Feedback',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.black87,
                    ),
                    title: 'About Us',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.description_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Terms & conditions',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.lock_outline,
                      color: Colors.black87,
                    ),
                    title: 'Privacy Policy',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: SvgPicture.asset(
                      'assets/svgs/rate.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Rate App',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  _DrawerItem(
                    leading: const Icon(
                      Icons.share_outlined,
                      color: Colors.black87,
                    ),
                    title: 'Share App',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 100,
                    thickness: 1,
                    height: 24,
                  ),
                  _DrawerItem(
                    leading: const Icon(Icons.logout, color: Colors.black87),
                    title: 'Logout',
                    onTap: (ctx) async => Navigator.pop(ctx),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Version 1.0.0 (0000)',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.leading,
    required this.title,
    required this.onTap,
  });

  final Widget leading;
  final String title;
  final Future<void> Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () => onTap(context),
    );
  }
}
