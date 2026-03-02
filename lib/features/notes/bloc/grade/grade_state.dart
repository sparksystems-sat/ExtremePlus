import 'package:equatable/equatable.dart';
import 'package:exam_practice_app/model/home_page_layout.dart';
import 'package:flutter/material.dart';



@immutable
abstract class GradeState extends Equatable {}

class GradeInitialState extends GradeState {
  @override
  List<Object?> get props => [];
}

class GradeSuccessState extends GradeState {
  GradeSuccessState(this.gradeModel);

  final List<GradeModel> gradeModel;
  @override
  List<Object?> get props => [gradeModel];
}

class GradeErrorState extends GradeState {
  @override
  List<Object?> get props => [];
}
