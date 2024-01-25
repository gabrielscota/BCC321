import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/seller_products_event.dart';
part '../state/seller_products_state.dart';

class SellerProductsBloc extends Bloc<SellerProductsEvent, SellerProductsState> {
  final FetchSellerProductsListUseCase fetchSellerProductListUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  SellerProductsBloc({
    required this.fetchSellerProductListUseCase,
    required this.deleteProductUseCase,
  }) : super(SellerProductsInitialState()) {
    on<SellerProductsStartedEvent>(_load);
    on<SellerProductsDeleteProductEvent>(_deleteProduct);
  }

  late List<ProductEntity> _products = [];

  FutureOr<void> _load(SellerProductsEvent event, Emitter<SellerProductsState> emit) async {
    if (event is SellerProductsStartedEvent) {
      emit(SellerProductsPageLoadingState());

      final productResult = await fetchSellerProductListUseCase.call(sellerId: event.sellerId);

      if (productResult.isLeft) {
        return emit(SellerProductsPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        _products = productResult.right;
        return emit(
          SellerProductsPageLoadedState(
            products: productResult.right,
          ),
        );
      }
    }
  }

  FutureOr<void> _deleteProduct(SellerProductsEvent event, Emitter<SellerProductsState> emit) async {
    if (event is SellerProductsDeleteProductEvent) {
      emit(SellerProductsPageLoadingState());

      final deleteResult = await deleteProductUseCase.call(productId: event.productId);

      if (deleteResult.isLeft) {
        return emit(SellerProductsPageErrorState(message: deleteResult.left.message));
      } else if (deleteResult.isRight) {
        _products.removeWhere((element) => element.id == event.productId);
        emit(SellerProductsPageDeleteSuccessState());
        return emit(SellerProductsPageLoadedState(products: _products));
      }
    }
  }
}
