import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GradeSelectionEvenet extends Equatable {
  const GradeSelectionEvenet();
}

class GradeSelectionInitialEvent extends GradeSelectionEvenet {
  @override
  List<Object?> get props => [];
}

class GradeSelectionUpdateEvent extends GradeSelectionEvenet {
  @override
  List<Object?> get props => [];
}

class GradeSelectionDeletedEvent extends GradeSelectionEvenet {
  @override
  List<Object?> get props => [];
}
