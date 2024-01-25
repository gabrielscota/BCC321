import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/usecases.dart';

part '../event/edit_product_event.dart';
part '../state/edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final EditProductUseCase editProductUseCase;

  EditProductBloc({
    required this.editProductUseCase,
  }) : super(EditProductInitialState()) {
    on<EditProductStartedEvent>(_editProduct);
  }

  FutureOr<void> _editProduct(EditProductEvent event, Emitter<EditProductState> emit) async {
    if (event is EditProductStartedEvent) {
      emit(EditProductLoadingState());

      final result = await editProductUseCase.call(
        params: EditProductUseCaseParams(
          productId: event.productId,
          description: event.description,
          stockQuantity: event.stockQuantity,
        ),
      );

      if (result.isLeft) {
        return emit(EditProductErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(EditProductSuccessfullState());
      }
    }
  }
}
