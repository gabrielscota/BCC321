import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/shopping_cart/shopping_cart.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/home_event.dart';
part '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchUserDetailsUseCase fetchUserDetailsUseCase;
  final FetchCategoryListUseCase fetchCategoryListUseCase;
  final FetchProductListUseCase fetchProductListUseCase;
  final UserSignOutUseCase userSignOutUseCase;
  final VerifyIfUserIsSellerUseCase verifyIfUserIsSellerUseCase;
  final NewOrderUseCase newOrderUseCase;

  HomeBloc({
    required this.fetchUserDetailsUseCase,
    required this.fetchProductListUseCase,
    required this.fetchCategoryListUseCase,
    required this.userSignOutUseCase,
    required this.verifyIfUserIsSellerUseCase,
    required this.newOrderUseCase,
  }) : super(HomeInitialState()) {
    on<HomeStartedEvent>(_load);
    on<HomeSignOutEvent>(_signOut);
    on<HomeLoadUserDetailsEvent>(_loadUserDetails);
    on<HomeVerifyIfUserIsSellerEvent>(_verifyIfUserIsSeller);
    on<HomeNewOrderEvent>(_newOrder);
    on<HomeLoadProductListEvent>(_loadProductList);
  }

  late UserEntity _user;
  late List<CategoryEntity> _categories;
  late List<ProductEntity> _products;

  late bool _userHasAddress;
  bool get userHasAddress => _userHasAddress;

  FutureOr<void> _load(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeStartedEvent) {
      emit(HomePageLoadingState());

      _userHasAddress = false;

      final userDetailsResult = await fetchUserDetailsUseCase.call();
      final categoryResult = await fetchCategoryListUseCase.call();
      final productResult = await fetchProductListUseCase.call();

      if (userDetailsResult.isLeft && categoryResult.isLeft && productResult.isLeft) {
        return emit(HomePageErrorState(message: categoryResult.left.message));
      } else if (userDetailsResult.isRight && categoryResult.isRight && productResult.isRight) {
        _user = userDetailsResult.right;
        _categories = categoryResult.right;
        _products = productResult.right;

        _userHasAddress = userDetailsResult.right.address.id.isNotEmpty;

        return emit(
          HomePageLoadedState(
            user: userDetailsResult.right,
            categories: categoryResult.right,
            products: productResult.right,
          ),
        );
      }
    }
  }

  FutureOr<void> _loadUserDetails(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeLoadUserDetailsEvent) {
      final userDetailsResult = await fetchUserDetailsUseCase.call();

      if (userDetailsResult.isLeft) {
        return emit(HomePageErrorState(message: userDetailsResult.left.message));
      } else if (userDetailsResult.isRight) {
        _userHasAddress = userDetailsResult.right.address.id.isNotEmpty;

        return emit(
          HomePageLoadedState(
            user: userDetailsResult.right,
            categories: _categories,
            products: _products,
          ),
        );
      }
    }
  }

  bool _userIsSeller = false;
  bool get userIsSeller => _userIsSeller;

  FutureOr<void> _verifyIfUserIsSeller(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeVerifyIfUserIsSellerEvent) {
      final userDetailsResult = await fetchUserDetailsUseCase.call();

      if (userDetailsResult.isLeft) {
        _userIsSeller = false;
        return;
      } else if (userDetailsResult.isRight) {
        final String userId = userDetailsResult.right.id;
        final result = await verifyIfUserIsSellerUseCase.call(userId: userId);

        if (result.isLeft) {
          _userIsSeller = false;
        } else if (result.isRight) {
          _userIsSeller = result.right;
        }
      }
    }
  }

  FutureOr<void> _newOrder(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeNewOrderEvent) {
      emit(HomePageDialogLoadingState());

      final result = await newOrderUseCase.call(
        params: NewOrderUseCaseParams(
          items: event.items,
          addressId: event.addressId,
          userId: event.userId,
        ),
      );

      if (result.isLeft) {
        return emit(HomePageErrorState(message: result.left.message));
      } else if (result.isRight) {
        final cartBloc = GetIt.I.get<CartBloc>();
        cartBloc.add(CartClearEvent());

        emit(HomePageNewOrderSuccessState());
        return emit(
          HomePageLoadedState(
            user: _user,
            categories: _categories,
            products: _products,
          ),
        );
      }
    }
  }

  FutureOr<void> _loadProductList(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeLoadProductListEvent) {
      final productResult = await fetchProductListUseCase.call(categoryId: event.categoryId);

      if (productResult.isLeft) {
        return emit(HomePageErrorState(message: productResult.left.message));
      } else if (productResult.isRight) {
        _products = productResult.right;

        return emit(
          HomePageLoadedState(
            user: _user,
            categories: _categories,
            products: productResult.right,
          ),
        );
      }
    }
  }

  FutureOr<void> _signOut(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeSignOutEvent) {
      emit(HomePageLoadingState());

      final result = await userSignOutUseCase.call();

      if (result.isLeft) {
        return emit(HomePageErrorState(message: result.left.message));
      } else if (result.isRight) {
        return emit(HomePageSignOutState());
      }
    }
  }
}
