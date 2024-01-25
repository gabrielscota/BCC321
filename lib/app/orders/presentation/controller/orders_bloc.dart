import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/orders_event.dart';
part '../state/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FetchOrderListUseCase fetchOrderListUseCase;

  OrdersBloc({
    required this.fetchOrderListUseCase,
  }) : super(OrdersInitialState()) {
    on<OrdersStartedEvent>(_load);
  }

  late List<OrderEntity> _orders = [];

  FutureOr<void> _load(OrdersEvent event, Emitter<OrdersState> emit) async {
    if (event is OrdersStartedEvent) {
      emit(OrdersPageLoadingState());

      final productResult = await fetchOrderListUseCase.call(userId: event.userId);

      if (productResult.isLeft) {
        return emit(OrdersPageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        _orders = productResult.right;
        return emit(
          OrdersPageLoadedState(
            orders: productResult.right,
          ),
        );
      }
    }
  }
}
