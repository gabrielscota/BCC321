import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/sign_in_event.dart';
part '../state/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc({
    required this.signInUseCase,
  }) : super(SignInInitialState()) {
    on<SignInStartedEvent>(_signIn);
  }

  FutureOr<void> _signIn(SignInEvent event, Emitter<SignInState> emit) async {
    if (event is SignInStartedEvent) {
      emit(SignInLoadingState());

      final result = await signInUseCase.call(email: event.email, password: event.password);

      if (result.isLeft) {
        return emit(SignInErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(SignInSuccessfullState());
      }
    }
  }
}
