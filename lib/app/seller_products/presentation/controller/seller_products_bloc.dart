import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/seller_products_event.dart';
part '../state/seller_products_state.dart';

class SellerProductsBloc extends Bloc<SellerProductsEvent, SellerProductsState> {
  final FetchSellerProductsListUseCase fetchSellerProductListUseCase;

  SellerProductsBloc({
    required this.fetchSellerProductListUseCase,
  }) : super(SellerProductsInitialState()) {
    on<SellerProductsStartedEvent>(_load);
  }

  FutureOr<void> _load(SellerProductsEvent event, Emitter<SellerProductsState> emit) async {
    if (event is SellerProductsStartedEvent) {
      emit(SellerProductsPageLoadingState());

      final productResult = await fetchSellerProductListUseCase.call(sellerId: event.sellerId);

      if (productResult.isLeft) {
        return emit(SellerProductsPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        return emit(
          SellerProductsPageLoadedState(
            products: productResult.right,
          ),
        );
      }
    }
  }
}
