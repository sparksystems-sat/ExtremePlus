import 'package:exam_practice_app/features/profile/models/user_profile.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, this.initialProfile});

  final UserProfile? initialProfile;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late UserProfile _profile;

  @override
  void initState() {
    super.initState();
    _profile =
        widget.initialProfile ??
        const UserProfile(
          fullName: 'Meklit Alebachew',
          gradeLabel: 'Grade 11',
          school: 'New Higher Secondary School',
          dateOfBirth: 'March 5, 2005',
          emailOrPhone: 'meklit.aleb@gmail.com',
          accountType: 'Student',
          accountStatus: 'Active',
          avatarAsset: 'assets/svgs/profile.jpeg',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync, color: Colors.black87),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 15),
            _InfoSection(
              items: [
                _InfoItem(label: 'Full Name', value: _profile.fullName),
                _InfoItem(label: 'Grade', value: _profile.gradeLabel),
                _InfoItem(label: 'School', value: _profile.school),
                _InfoItem(label: 'Date of Birth', value: _profile.dateOfBirth),
              ],
              showEditButton: true,
            ),
            const SizedBox(height: 15),
            const Divider(height: 1),
            const SizedBox(height: 30),
            _InfoSection(
              items: [
                _InfoItem(
                  label: 'Phone/Email',
                  value: _profile.emailOrPhone,
                  underline: true,
                ),
                _InfoItem(label: 'Account Type', value: _profile.accountType),
                _InfoItem(
                  label: 'Account Status',
                  value: _profile.accountStatus,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(_profile.avatarAsset),
            ),

            Positioned(
              bottom: 10,
              right: 4,

              child: SvgPicture.asset(
                'assets/svgs/edit.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        Text(
          _profile.fullName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          _profile.gradeLabel,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          _profile.school,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _InfoItem {
  const _InfoItem({
    required this.label,
    required this.value,
    this.underline = false,
  });

  final String label;
  final String value;
  final bool underline;
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.items, this.showEditButton = false});

  final List<_InfoItem> items;
  final bool showEditButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items) ...[
            _InfoRow(item: item),
            const SizedBox(height: 15),
          ],
          if (showEditButton) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button3Color,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item});

  final _InfoItem item;

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decoration:
          item.underline ? TextDecoration.underline : TextDecoration.none,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(item.value, style: valueStyle),
      ],
    );
  }
}
