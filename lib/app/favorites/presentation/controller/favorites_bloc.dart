import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/favorites_event.dart';
part '../state/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FetchFavoritesProductListUseCase fetchFavoritesProductListUseCase;

  FavoritesBloc({
    required this.fetchFavoritesProductListUseCase,
  }) : super(FavoritesInitialState()) {
    on<FavoritesStartedEvent>(_load);
  }

  FutureOr<void> _load(FavoritesEvent event, Emitter<FavoritesState> emit) async {
    if (event is FavoritesStartedEvent) {
      emit(FavoritesPageLoadingState());

      final productResult = await fetchFavoritesProductListUseCase.call(userId: event.userId);

      if (productResult.isLeft) {
        return emit(FavoritesPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        return emit(
          FavoritesPageLoadedState(
            products: productResult.right,
          ),
        );
      }
    }
  }
}
