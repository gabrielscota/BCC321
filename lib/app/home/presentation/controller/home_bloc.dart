import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/home_event.dart';
part '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCategoryListUseCase fetchCategoryListUseCase;
  final FetchProductListUseCase fetchProductListUseCase;

  HomeBloc({
    required this.fetchProductListUseCase,
    required this.fetchCategoryListUseCase,
  }) : super(HomeInitialState()) {
    on<HomeStartedEvent>(_load);
  }

  FutureOr<void> _load(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeStartedEvent) {
      emit(HomePageLoadingState());

      final categoryResult = await fetchCategoryListUseCase.call();
      final productResult = await fetchProductListUseCase.call();

      if (categoryResult.isLeft && productResult.isLeft) {
        return emit(HomePageErrorState(message: categoryResult.left.message));
      } else if (categoryResult.isRight && productResult.isRight) {
        return emit(HomePageLoadedState(categories: categoryResult.right, products: productResult.right));
      }
    }
  }
}
