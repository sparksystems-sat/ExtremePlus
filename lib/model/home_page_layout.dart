import 'package:flutter/material.dart';

class HomePageLayout {
  final String label;
  final GradeModel description;
  HomePageLayout({required this.label, required this.description});
}

class GradeModel {
  final String label;
  final String id;
  final IconData icon;
  final Color color;
  GradeModel({
    required this.icon,
    required this.color,
    required this.label,
    required this.id,
  });
  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      icon: json['icon'] ?? Icons.school,
      color: json['color'] ?? Colors.blue,
      label: json['label'] ?? '',
      id: json['id'].toString(),
    );
  }
}
