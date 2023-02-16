import 'package:equatable/equatable.dart';

import '../../model/product.dart';

enum StoreRequest {
  unknown,
  requestInProgress,
  requestSuccess,
  requestFailure,
}

class HomeState extends Equatable {
  final List<Product> products;
  final StoreRequest productsStatus;
  final Set<int> cartIds;

  const HomeState({
    this.products = const [],
    this.productsStatus = StoreRequest.unknown,
    this.cartIds = const {},
  });

  @override
  List<Object?> get props => [
        products,
        productsStatus,
        cartIds,
      ];

  HomeState copyWith({
    List<Product>? products,
    StoreRequest? productsStatus,
    Set<int>? cartIds,
  }) =>
      HomeState(
        products: products ?? this.products,
        productsStatus: productsStatus ?? this.productsStatus,
        cartIds: cartIds ?? this.cartIds,
      );
}
