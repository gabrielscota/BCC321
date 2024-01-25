import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/add_address_event.dart';
part '../state/add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddAddressUseCase addAddressUseCase;

  AddAddressBloc({
    required this.addAddressUseCase,
  }) : super(AddAddressInitialState()) {
    on<AddAddressStartedEvent>(_addAddress);
  }

  FutureOr<void> _addAddress(AddAddressEvent event, Emitter<AddAddressState> emit) async {
    if (event is AddAddressStartedEvent) {
      emit(AddAddressLoadingState());

      final result = await addAddressUseCase.call(
        params: AddAddressUseCaseParams(
          userId: event.userId,
          city: event.city,
          state: event.state,
          number: event.number,
          street: event.street,
          country: event.country,
          zipCode: event.zipCode,
        ),
      );

      if (result.isLeft) {
        return emit(AddAddressErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(AddAddressSuccessfullState());
      }
    }
  }
}
