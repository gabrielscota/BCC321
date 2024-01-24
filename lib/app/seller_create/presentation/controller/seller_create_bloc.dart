import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/seller_create_event.dart';
part '../state/seller_create_state.dart';

class SellerCreateBloc extends Bloc<SellerCreateEvent, SellerCreateState> {
  final SellerCreateUseCase sellerCreateUseCase;

  SellerCreateBloc({
    required this.sellerCreateUseCase,
  }) : super(SellerCreateInitialState()) {
    on<SellerCreateStartedEvent>(_createShop);
  }

  FutureOr<void> _createShop(SellerCreateEvent event, Emitter<SellerCreateState> emit) async {
    if (event is SellerCreateStartedEvent) {
      emit(SellerCreateLoadingState());

      final result = await sellerCreateUseCase.call(
        params: SellerCreateUseCaseParams(
          shopName: event.shopName,
          shopDescription: event.shopDescription,
          userId: event.userId,
        ),
      );

      if (result.isLeft) {
        return emit(SellerCreateErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(SellerCreateSuccessfullState());
      }
    }
  }
}
