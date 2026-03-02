import 'package:exam_practice_app/bloc/home/home_state.dart';
import 'package:exam_practice_app/bloc/home/home_event.dart';
import 'package:exam_practice_app/repos/home_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitialState()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeInitialState());
      try {
        final gradeModel = await homeRepository.getHomeData();
        emit(HomeSuccessState(gradeModel));
      } catch (e) {
        emit(HomeErrorState());
      }
    });
  }
}
