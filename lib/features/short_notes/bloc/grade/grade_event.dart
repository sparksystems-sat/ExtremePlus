import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GradeEvent extends Equatable {
  const GradeEvent();
}

class GradeInitialEvent extends GradeEvent {
  @override
  List<Object?> get props => [];
}

class GradeUpdateEvent extends GradeEvent {
  @override
  List<Object?> get props => [];
}

class GradeDeletedEvent extends GradeEvent {
  @override
  List<Object?> get props => [];
}
