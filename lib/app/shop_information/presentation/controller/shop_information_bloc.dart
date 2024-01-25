import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/shop_information_event.dart';
part '../state/shop_information_state.dart';

class ShopInformationBloc extends Bloc<ShopInformationEvent, ShopInformationState> {
  final EditShopInformationUseCase editShopInformationUseCase;

  ShopInformationBloc({
    required this.editShopInformationUseCase,
  }) : super(ShopInformationInitialState()) {
    on<ShopInformationStartedEvent>(_editShopInformation);
  }

  FutureOr<void> _editShopInformation(ShopInformationEvent event, Emitter<ShopInformationState> emit) async {
    if (event is ShopInformationStartedEvent) {
      emit(ShopInformationLoadingState());

      final result = await editShopInformationUseCase.call(
        params: EditShopInformationUseCaseParams(
          sellerId: event.sellerId,
          shopName: event.shopName,
          description: event.description,
        ),
      );

      if (result.isLeft) {
        return emit(ShopInformationErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(ShopInformationSuccessfullState());
      }
    }
  }
}
