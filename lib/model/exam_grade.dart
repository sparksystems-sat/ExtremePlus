import 'package:flutter/material.dart';

class ExamGradeModel {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  ExamGradeModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
  factory ExamGradeModel.fromJson(Map<String, dynamic> json) {
    return ExamGradeModel(
      id: json['id'] as String,
      label: json['label'] as String,
      icon: json['icon'] as IconData,
      color: json['color'] as Color,
    );
  }
}
