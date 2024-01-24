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

      final result = await signUpUseCase.call(
        params: SignUpUseCaseParams(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
          isPhysicalPerson: event.isPhysicalPerson,
          cpf: event.cpf,
          cnpj: event.cnpj,
        ),
      );

      if (result.isLeft) {
        return emit(SignUpErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(SignUpSuccessfullState());
      }
    }
  }
}
