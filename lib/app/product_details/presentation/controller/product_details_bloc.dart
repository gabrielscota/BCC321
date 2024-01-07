import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/product_details_event.dart';
part '../state/product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<ProductDetailsStartedEvent>(_load);
  }

  FutureOr<void> _load(ProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (event is ProductDetailsStartedEvent) {
      emit(ProductDetailsPageLoadingState());

      await Future.delayed(const Duration(seconds: 1));

      emit(ProductDetailsPageLoadedState());
    }
  }
}
