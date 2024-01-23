import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/seller_event.dart';
part '../state/seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final FetchSellerCategoryListUseCase fetchCategoryListUseCase;
  final FetchSellerProductListUseCase fetchSellerProductListUseCase;

  SellerBloc({
    required this.fetchSellerProductListUseCase,
    required this.fetchCategoryListUseCase,
  }) : super(SellerInitialState()) {
    on<SellerStartedEvent>(_load);
  }

  FutureOr<void> _load(SellerEvent event, Emitter<SellerState> emit) async {
    if (event is SellerStartedEvent) {
      emit(SellerPageLoadingState());

      final categoryResult = await fetchCategoryListUseCase.call();
      final productResult = await fetchSellerProductListUseCase.call(sellerId: event.sellerId);

      if (categoryResult.isLeft && productResult.isLeft) {
        return emit(SellerPageErrorState(message: categoryResult.left.message));
      } else if (categoryResult.isRight && productResult.isRight) {
        return emit(
          SellerPageLoadedState(
            categories: categoryResult.right,
            products: productResult.right,
          ),
        );
      }
    }
  }
}
