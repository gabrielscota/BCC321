import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/add_product_event.dart';
part '../state/add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase addProductUseCase;
  final AddProductFetchCategoryListUseCase fetchCategoryListUseCase;

  AddProductBloc({
    required this.addProductUseCase,
    required this.fetchCategoryListUseCase,
  }) : super(AddProductInitialState()) {
    on<AddProductLoadCategoriesEvent>(_loadCategories);
    on<AddProductStartedEvent>(_addProduct);
  }

  FutureOr<void> _loadCategories(AddProductEvent event, Emitter<AddProductState> emit) async {
    if (event is AddProductLoadCategoriesEvent) {
      final categoryResult = await fetchCategoryListUseCase.call();

      if (categoryResult.isLeft) {
        return emit(AddProductErrorState(message: categoryResult.left.message));
      } else if (categoryResult.isRight) {
        return emit(
          AddProductLoadedState(
            categories: categoryResult.right,
          ),
        );
      }
    }
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
