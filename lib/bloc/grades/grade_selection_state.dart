import 'package:equatable/equatable.dart';
import 'package:exam_practice_app/model/home_page_layout.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GradeSelectionState extends Equatable {}

class GradeSelectionInitialState extends GradeSelectionState {
  @override
  List<Object?> get props => [];
}

class GradeSelectionSuccessState extends GradeSelectionState {
  GradeSelectionSuccessState(this.gradeModel);

  final List<GradeModel> gradeModel;
  @override
  List<Object?> get props => [gradeModel];
}

class GradeSelectionErrorState extends GradeSelectionState {
  @override
  List<Object?> get props => [];
}
