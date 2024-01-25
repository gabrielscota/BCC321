import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/product_details_event.dart';
part '../state/product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final FetchProductDetailsUseCase fetchProductDetailsUseCase;
  final FavoriteProductUseCase favoriteProductUseCase;

  ProductDetailsBloc({
    required this.fetchProductDetailsUseCase,
    required this.favoriteProductUseCase,
  }) : super(ProductDetailsInitialState()) {
    on<ProductDetailsStartedEvent>(_load);
    on<ProductDetailsFavoriteEvent>(_favorite);
  }

  late ProductEntity _product;

  FutureOr<void> _load(ProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (event is ProductDetailsStartedEvent) {
      emit(ProductDetailsPageLoadingState());

      final productResult = await fetchProductDetailsUseCase.call(userId: event.userId, productId: event.productId);

      if (productResult.isLeft) {
        return emit(ProductDetailsPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        _product = productResult.right;
        return emit(ProductDetailsPageLoadedState(product: productResult.right));
      }
    }
  }

  FutureOr<void> _favorite(ProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (event is ProductDetailsFavoriteEvent) {
      final favoriteResult = await favoriteProductUseCase.call(userId: event.userId, productId: event.productId);

      if (favoriteResult.isLeft) {
        return emit(ProductDetailsPageErrorState(message: favoriteResult.left.message));
      } else if (favoriteResult.isRight) {
        _product = _product.copyWith(isFavorited: favoriteResult.right);
        emit(ProductDetailsPageFavoriteSuccessState(isFavorited: favoriteResult.right));
        return emit(ProductDetailsPageLoadedState(product: _product));
      }
    }
  }
}
