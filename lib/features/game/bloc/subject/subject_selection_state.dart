import 'package:equatable/equatable.dart';
import 'package:exam_practice_app/model/exam_grade.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SubjectctSelectionState extends Equatable {}

class SubjectctSelectionInitialState extends SubjectctSelectionState {
  @override
  List<Object?> get props => [];
}

class SubjectctSelectionSuccessState extends SubjectctSelectionState {
  SubjectctSelectionSuccessState(this.SubjectctSelectionModel);

  final List<ExamGradeModel> SubjectctSelectionModel;
  @override
  List<Object?> get props => [SubjectctSelectionModel];
}

class SubjectctSelectionErrorState extends SubjectctSelectionState {
  @override
  List<Object?> get props => [];
}
