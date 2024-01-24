import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/home_event.dart';
part '../state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchUserDetailsUseCase fetchUserDetailsUseCase;
  final FetchCategoryListUseCase fetchCategoryListUseCase;
  final FetchProductListUseCase fetchProductListUseCase;
  final FetchSellerListUseCase fetchSellerListUseCase;
  final UserSignOutUseCase userSignOutUseCase;
  final VerifyIfUserIsSellerUseCase verifyIfUserIsSellerUseCase;

  HomeBloc({
    required this.fetchUserDetailsUseCase,
    required this.fetchProductListUseCase,
    required this.fetchCategoryListUseCase,
    required this.fetchSellerListUseCase,
    required this.userSignOutUseCase,
    required this.verifyIfUserIsSellerUseCase,
  }) : super(HomeInitialState()) {
    on<HomeStartedEvent>(_load);
    on<HomeSignOutEvent>(_signOut);
    on<HomeVerifyIfUserIsSellerEvent>(_verifyIfUserIsSeller);
  }

  FutureOr<void> _load(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeStartedEvent) {
      emit(HomePageLoadingState());

      final userDetailsResult = await fetchUserDetailsUseCase.call();
      final categoryResult = await fetchCategoryListUseCase.call();
      final productResult = await fetchProductListUseCase.call();
      final sellerResult = await fetchSellerListUseCase.call();

      if (userDetailsResult.isLeft && categoryResult.isLeft && productResult.isLeft && sellerResult.isLeft) {
        return emit(HomePageErrorState(message: categoryResult.left.message));
      } else if (userDetailsResult.isRight && categoryResult.isRight && productResult.isRight && sellerResult.isRight) {
        return emit(
          HomePageLoadedState(
            user: userDetailsResult.right,
            categories: categoryResult.right,
            products: productResult.right,
            sellers: sellerResult.right,
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
