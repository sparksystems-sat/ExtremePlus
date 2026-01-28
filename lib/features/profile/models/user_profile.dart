class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.gradeLabel,
    required this.school,
    required this.dateOfBirth,
    required this.emailOrPhone,
    required this.accountType,
    required this.accountStatus,
    required this.avatarAsset,
  });

  final String fullName;
  final String gradeLabel;
  final String school;
  final String dateOfBirth;
  final String emailOrPhone;
  final String accountType;
  final String accountStatus;
  final String avatarAsset;

  UserProfile copyWith({
    String? fullName,
    String? gradeLabel,
    String? school,
    String? dateOfBirth,
    String? emailOrPhone,
    String? accountType,
    String? accountStatus,
    String? avatarAsset,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      gradeLabel: gradeLabel ?? this.gradeLabel,
      school: school ?? this.school,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      accountType: accountType ?? this.accountType,
      accountStatus: accountStatus ?? this.accountStatus,
      avatarAsset: avatarAsset ?? this.avatarAsset,
    );
  }
}
