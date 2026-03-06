import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExamEvent extends Equatable {
  const ExamEvent();
}

class ExamInitialEvent extends ExamEvent {
  @override
  List<Object?> get props => [];
}

class ExamSubmitAnswerEvent extends ExamEvent {
  final Map<String, dynamic> selectedAnswers;
  final String subjectId;

  const ExamSubmitAnswerEvent(this.subjectId, this.selectedAnswers);

  @override
  List<Object?> get props => [selectedAnswers];
}
