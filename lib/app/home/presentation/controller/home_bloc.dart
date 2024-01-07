import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/home_event.dart';
part '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeStartedEvent>(_load);
  }

  FutureOr<void> _load(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeStartedEvent) {
      emit(HomePageLoadingState());

      await Future.delayed(const Duration(seconds: 1));

      emit(HomePageLoadedState());
    }
  }
}
