import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/edit_coupon_event.dart';
part '../state/edit_coupon_state.dart';

class EditCouponBloc extends Bloc<EditCouponEvent, EditCouponState> {
  final EditCouponUseCase editCouponUseCase;

  EditCouponBloc({
    required this.editCouponUseCase,
  }) : super(EditCouponInitialState()) {
    on<EditCouponStartedEvent>(_editCoupon);
  }

  FutureOr<void> _editCoupon(EditCouponEvent event, Emitter<EditCouponState> emit) async {
    if (event is EditCouponStartedEvent) {
      emit(EditCouponLoadingState());

      final result = await editCouponUseCase.call(
        params: EditCouponUseCaseParams(
          couponId: event.couponId,
          discountCode: event.discountCode,
          discountValue: event.discountValue,
        ),
      );

      if (result.isLeft) {
        return emit(EditCouponErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(EditCouponSuccessfullState());
      }
    }
  }
}
