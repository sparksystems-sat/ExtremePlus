import 'package:exam_practice_app/bloc/subject/subject_selection_event.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_state.dart';
import 'package:exam_practice_app/repos/subject_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectctSelectionBloc
    extends Bloc<SubjectctSelectionEvent, SubjectctSelectionState> {
  final SubjectSelectionRepository subject_repo;
  SubjectctSelectionBloc(this.subject_repo)
    : super(SubjectctSelectionInitialState()) {
    on<SubjectctSelectionInitialEvent>((event, emit) async {
      emit(SubjectctSelectionInitialState());
      try {
        final subject_selected_data = await subject_repo.getSubjectData();
        emit(SubjectctSelectionSuccessState(subject_selected_data));
      } catch (e) {
        emit(SubjectctSelectionErrorState());
      }
    });
  }
}
