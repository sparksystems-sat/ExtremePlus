import 'package:exam_practice_app/features/exam_practice/bloc/exam/exam_event.dart';
import 'package:exam_practice_app/features/exam_practice/bloc/exam/exam_state.dart';
import 'package:exam_practice_app/features/exam_practice/repositorys/exam_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRepository exam_repo;
  final String subjectId;
  ExamBloc(this.exam_repo, this.subjectId) : super(ExamInitialState()) {
    on<ExamInitialEvent>((event, emit) async {
      emit(ExamInitialState());
      try {
        final exam_selected_data = await exam_repo.getExamData(subjectId);
        emit(ExamSuccessState(exam_selected_data));
      } catch (e) {
        emit(ExamErrorState());
      }
    });
    on<ExamSubmitAnswerEvent>((event, emit) async {
      try {
        await exam_repo.submitExamAnswer(
          event.subjectId,
          event.selectedAnswers,
        );
      } catch (e) {
        emit(ExamErrorState());
      }
    });
  }
}
