import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part '../event/splash_event.dart';
part '../state/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashStartedEvent>(_load);
  }

  FutureOr<void> _load(SplashEvent event, Emitter<SplashState> emit) async {
    if (event is SplashStartedEvent) {
      emit(SplashPageLoadingState());

      final SupabaseClient supabase = Supabase.instance.client;
      final session = supabase.auth.currentSession;

      await Future.delayed(const Duration(seconds: 1));

      emit(SplashPageLoadedState(currentSession: session != null ? session.accessToken : ''));
    }
  }
}
