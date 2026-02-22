import 'package:equatable/equatable.dart';
import 'package:exam_practice_app/model/home_page_layout.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  HomeSuccessState(this.gradeModel);

  final List<GradeModel> gradeModel;
  @override
  List<Object?> get props => [gradeModel];
}

class HomeErrorState extends HomeState {
  @override
  List<Object?> get props => [];
}
