import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

      await dotenv.load();

      await Future.wait([
        Supabase.initialize(
          url: dotenv.env['SUPABASE_URL'] ?? '',
          anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
        ),
        Future.delayed(const Duration(seconds: 1)),
      ]);

      emit(SplashPageLoadedState());
    }
  }
}
