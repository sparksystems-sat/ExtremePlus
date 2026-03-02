import 'package:equatable/equatable.dart';
import 'package:exam_practice_app/model/question_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExamState extends Equatable {}

class ExamInitialState extends ExamState {
  @override
  List<Object?> get props => [];
}

class ExamSuccessState extends ExamState {
  ExamSuccessState(this.ExamModel);

  final List<QuestionModel> ExamModel;
  @override
  List<Object?> get props => [ExamModel];
}

class ExamSubmitAnswerState extends ExamState {
  ExamSubmitAnswerState(this.ExamModel);

  final List<QuestionModel> ExamModel;
  @override
  List<Object?> get props => [ExamModel];
}

class ExamErrorState extends ExamState {
  @override
  List<Object?> get props => [];
}
