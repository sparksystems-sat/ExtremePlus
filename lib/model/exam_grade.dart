import 'package:flutter/material.dart';

class ExamGradeModel {
  final String id;
  final String subject_title;
  final IconData icon;
  final Color color;

  ExamGradeModel({
    required this.id,
    required this.subject_title,
    required this.icon,
    required this.color,
  });
  factory ExamGradeModel.fromJson(Map<String, dynamic> json) {
    return ExamGradeModel(
      id: json['id'] as String,
      subject_title: json['subject_title'] as String,
      icon: Icons.school,
      color: const Color(0xFF4CAF50),
    );
  }
}
