import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/edit_address_event.dart';
part '../state/edit_address_state.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  final EditAddressUseCase editAddressUseCase;

  EditAddressBloc({
    required this.editAddressUseCase,
  }) : super(EditAddressInitialState()) {
    on<EditAddressStartedEvent>(_editAddress);
  }

  FutureOr<void> _editAddress(EditAddressEvent event, Emitter<EditAddressState> emit) async {
    if (event is EditAddressStartedEvent) {
      emit(EditAddressLoadingState());

      final result = await editAddressUseCase.call(
        params: EditAddressUseCaseParams(
          addressId: event.addressId,
          street: event.street,
          number: event.number,
          city: event.city,
          state: event.state,
          country: event.country,
          zipCode: event.zipCode,
        ),
      );

      if (result.isLeft) {
        return emit(EditAddressErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(EditAddressSuccessfullState());
      }
    }
  }
}
