import 'package:exam_practice_app/bloc/grade/grade_event.dart';
import 'package:exam_practice_app/bloc/grade/grade_state.dart';
import 'package:exam_practice_app/repos/grade_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final GradeRepository grade_repo;
  GradeBloc(this.grade_repo) : super(GradeInitialState()) {
    on<GradeInitialEvent>((event, emit) async {
      emit(GradeInitialState());
      try {
        final gradeModel = await grade_repo.getGradeData();
        emit(GradeSuccessState(gradeModel));
      } catch (e) {
        emit(GradeErrorState());
      }
    });
  }
}
