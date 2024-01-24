import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/seller_event.dart';
part '../state/seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final FetchSellerDetailsUseCase fetchSellerDetailsUseCase;

  SellerBloc({
    required this.fetchSellerDetailsUseCase,
  }) : super(SellerInitialState()) {
    on<SellerStartedEvent>(_load);
  }

  FutureOr<void> _load(SellerEvent event, Emitter<SellerState> emit) async {
    if (event is SellerStartedEvent) {
      emit(SellerPageLoadingState());

      final sellerResult = await fetchSellerDetailsUseCase.call(sellerId: event.sellerId);

      if (sellerResult.isLeft) {
        return emit(SellerPageErrorState(message: sellerResult.left.message));
      } else if (sellerResult.isRight) {
        return emit(
          SellerPageLoadedState(
            seller: sellerResult.right,
          ),
        );
      }
    }
  }
}
