import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part '../event/seller_coupons_event.dart';
part '../state/seller_coupons_state.dart';

class SellerCouponsBloc extends Bloc<SellerCouponsEvent, SellerCouponsState> {
  final FetchSellerCouponsListUseCase fetchSellerProductListUseCase;
  final DeleteCouponUseCase deleteCouponUseCase;

  SellerCouponsBloc({
    required this.fetchSellerProductListUseCase,
    required this.deleteCouponUseCase,
  }) : super(SellerCouponsInitialState()) {
    on<SellerCouponsStartedEvent>(_load);
    on<SellerCouponsDeleteCouponEvent>(_deleteCoupon);
  }

  late List<CouponEntity> _coupons = [];

  FutureOr<void> _load(SellerCouponsEvent event, Emitter<SellerCouponsState> emit) async {
    if (event is SellerCouponsStartedEvent) {
      emit(SellerCouponsPageLoadingState());

      final couponResult = await fetchSellerProductListUseCase.call(sellerId: event.sellerId);

      if (couponResult.isLeft) {
        return emit(SellerCouponsPageErrorState(message: couponResult.left.message));
      } else if (couponResult.isRight) {
        _coupons = couponResult.right;
        return emit(
          SellerCouponsPageLoadedState(
            coupons: couponResult.right,
          ),
        );
      }
    }
  }

  FutureOr<void> _deleteCoupon(SellerCouponsEvent event, Emitter<SellerCouponsState> emit) async {
    if (event is SellerCouponsDeleteCouponEvent) {
      emit(SellerCouponsPageLoadingState());

      final deleteResult = await deleteCouponUseCase.call(couponId: event.couponId);

      if (deleteResult.isLeft) {
        return emit(SellerCouponsPageErrorState(message: deleteResult.left.message));
      } else if (deleteResult.isRight) {
        _coupons.removeWhere((element) => element.id == event.couponId);
        emit(SellerCouponsPageDeleteSuccessState());
        return emit(SellerCouponsPageLoadedState(coupons: _coupons));
      }
    }
  }
}
