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

class ExamSubmitSingleAnswerEvent extends ExamEvent {
  final Map<String, dynamic> selectedAnswers;
  final String subjectId;

  const ExamSubmitSingleAnswerEvent(this.subjectId, this.selectedAnswers);

  @override
  List<Object?> get props => [selectedAnswers];
}

class ExamSubmitBulkAnswerEvent extends ExamEvent {
  final Map<String, dynamic> selectedAnswers;
  final String subjectId;

  const ExamSubmitBulkAnswerEvent(this.subjectId, this.selectedAnswers);

  @override
  List<Object?> get props => [selectedAnswers];
}

class ExamSubmitClearAnswerEvent extends ExamEvent {
  final String subjectId;

  const ExamSubmitClearAnswerEvent(this.subjectId);

  @override
  List<Object?> get props => [subjectId];
}
