import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/sign_up_event.dart';
part '../state/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({
    required this.signUpUseCase,
  }) : super(SignUpInitialState()) {
    on<SignUpStartedEvent>(_signUp);
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpStartedEvent) {
      emit(SignUpLoadingState());

      final result = await signUpUseCase.call(email: event.email, password: event.password);

      if (result.isLeft) {
        return emit(SignUpPageErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(SignUpSuccessfullState());
      }
    }
  }
}
