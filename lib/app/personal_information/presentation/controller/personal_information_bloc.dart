import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/personal_information_event.dart';
part '../state/personal_information_state.dart';

class PersonalInformationBloc extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final EditPersonalInformationUseCase editPersonalInformationUseCase;

  PersonalInformationBloc({
    required this.editPersonalInformationUseCase,
  }) : super(PersonalInformationInitialState()) {
    on<PersonalInformationStartedEvent>(_editPersonalInformation);
  }

  FutureOr<void> _editPersonalInformation(
      PersonalInformationEvent event, Emitter<PersonalInformationState> emit) async {
    if (event is PersonalInformationStartedEvent) {
      emit(PersonalInformationLoadingState());

      final result = await editPersonalInformationUseCase.call(
        params: EditPersonalInformationUseCaseParams(
          userId: event.userId,
          name: event.name,
          phone: event.phone,
        ),
      );

      if (result.isLeft) {
        return emit(PersonalInformationErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(PersonalInformationSuccessfullState());
      }
    }
  }
}
