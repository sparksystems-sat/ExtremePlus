import 'package:flutter/material.dart';

class ExamSubject {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int progress;

  ExamSubject({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.progress,
  });
}
