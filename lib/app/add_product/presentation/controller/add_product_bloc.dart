import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/add_product_event.dart';
part '../state/add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase addProductUseCase;

  AddProductBloc({
    required this.addProductUseCase,
  }) : super(AddProductInitialState()) {
    on<AddProductStartedEvent>(_addProduct);
  }

  FutureOr<void> _addProduct(AddProductEvent event, Emitter<AddProductState> emit) async {
    if (event is AddProductStartedEvent) {
      emit(AddProductLoadingState());

      final result = await addProductUseCase.call(
        params: AddProductUseCaseParams(
          name: event.name,
          description: event.description,
          price: event.price,
          categoryId: event.categoryId,
          stockQuantity: event.stockQuantity,
          sellerId: event.sellerId,
        ),
      );

      if (result.isLeft) {
        return emit(AddProductErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(AddProductSuccessfullState());
      }
    }
  }
}
