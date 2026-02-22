import 'package:flutter/material.dart';

class ExamGrade {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  ExamGrade({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  static fromJson(e) {}
}
