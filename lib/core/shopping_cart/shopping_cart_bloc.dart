import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CartEvent {}

class CartAddEvent implements CartEvent {
  final Map<String, dynamic> item;

  CartAddEvent({required this.item});
}

class CartRemoveEvent implements CartEvent {
  final String itemId;

  CartRemoveEvent({required this.itemId});
}

class CartClearEvent implements CartEvent {}

class CartState {
  final List<Map<String, dynamic>> items;

  CartState({this.items = const []});

  CartState addItem(Map<String, dynamic> item) {
    return CartState(items: [...items, item]);
  }

  CartState removeItem(String itemId) {
    return CartState(items: items.where((i) => i['id'] != itemId).toList());
  }
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<CartAddEvent>((event, emit) {
      emit(state.addItem(event.item));
    });
    on<CartRemoveEvent>((event, emit) {
      emit(state.removeItem(event.itemId));
    });
    on<CartClearEvent>((event, emit) {
      emit(CartState());
    });
  }
}
