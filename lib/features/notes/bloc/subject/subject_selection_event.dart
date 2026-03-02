import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SubjectctSelectionEvent extends Equatable {
  const SubjectctSelectionEvent();
}

class SubjectctSelectionInitialEvent extends SubjectctSelectionEvent {
  @override
  List<Object?> get props => [];
}
