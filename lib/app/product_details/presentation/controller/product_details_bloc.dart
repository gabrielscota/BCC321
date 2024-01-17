import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/product_details_event.dart';
part '../state/product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final FetchProductDetailsUseCase fetchProductDetailsUseCase;

  ProductDetailsBloc({required this.fetchProductDetailsUseCase}) : super(ProductDetailsInitialState()) {
    on<ProductDetailsStartedEvent>(_load);
  }

  FutureOr<void> _load(ProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (event is ProductDetailsStartedEvent) {
      emit(ProductDetailsPageLoadingState());

      final productResult = await fetchProductDetailsUseCase.call(productId: event.productId);

      if (productResult.isLeft) {
        return emit(ProductDetailsPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        return emit(ProductDetailsPageLoadedState(product: productResult.right));
      }
    }
  }
}
