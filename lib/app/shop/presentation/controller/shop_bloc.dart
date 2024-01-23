import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/shop_event.dart';
part '../state/shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final FetchShopDetailsUseCase fetchSellerDetailsUseCase;
  final FetchShopProductListUseCase fetchSellerProductListUseCase;

  ShopBloc({
    required this.fetchSellerDetailsUseCase,
    required this.fetchSellerProductListUseCase,
  }) : super(ShopInitialState()) {
    on<ShopStartedEvent>(_load);
  }

  FutureOr<void> _load(ShopEvent event, Emitter<ShopState> emit) async {
    if (event is ShopStartedEvent) {
      emit(ShopPageLoadingState());

      final sellerResult = await fetchSellerDetailsUseCase.call(sellerId: event.sellerId);
      final productResult = await fetchSellerProductListUseCase.call(sellerId: event.sellerId);

      if (sellerResult.isLeft && productResult.isLeft) {
        return emit(ShopPageErrorState(message: sellerResult.left.message));
      } else if (sellerResult.isRight && productResult.isRight) {
        return emit(
          ShopPageLoadedState(
            seller: sellerResult.right,
            products: productResult.right,
          ),
        );
      }
    }
  }
}
