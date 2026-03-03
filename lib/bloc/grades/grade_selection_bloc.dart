import 'package:exam_practice_app/bloc/grades/grade_selection_evenet.dart';
import 'package:exam_practice_app/bloc/grades/grade_selection_state.dart';
import 'package:exam_practice_app/repository/grade/grade_selection_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradeSelectionBloc
    extends Bloc<GradeSelectionEvenet, GradeSelectionState> {
  final GradeSelectionRepository grade_selection_repo;
  GradeSelectionBloc(this.grade_selection_repo)
    : super(GradeSelectionInitialState()) {
    on<GradeSelectionInitialEvent>((event, emit) async {
      emit(GradeSelectionInitialState());
      try {
        final gradeModel = await grade_selection_repo.getGradeSelectionData();
        emit(GradeSelectionSuccessState(gradeModel));
      } catch (e) {
        emit(GradeSelectionErrorState());
      }
    });
  }
}
