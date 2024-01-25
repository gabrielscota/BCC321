import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/add_coupon_event.dart';
part '../state/add_coupon_state.dart';

class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  final AddCouponUseCase addCouponUseCase;

  AddCouponBloc({
    required this.addCouponUseCase,
  }) : super(AddCouponInitialState()) {
    on<AddCouponStartedEvent>(_addCoupon);
  }

  FutureOr<void> _addCoupon(AddCouponEvent event, Emitter<AddCouponState> emit) async {
    if (event is AddCouponStartedEvent) {
      emit(AddCouponLoadingState());

      final result = await addCouponUseCase.call(
        params: AddCouponUseCaseParams(
          discountCode: event.discountCode,
          discountValue: event.discountValue,
          startDate: event.startDate,
          endDate: event.endDate,
          sellerId: event.sellerId,
        ),
      );

      if (result.isLeft) {
        return emit(AddCouponErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(AddCouponSuccessfullState());
      }
    }
  }
}
