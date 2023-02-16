import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/pages/controller/home_state.dart';

import '../../repository/store_repository.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({required this.repository}) : super(const HomeState()) {
    getStoreProductsRequested();
  }

  final StoreRepository repository;

  Future<void> getStoreProductsRequested() async {
    try {
      state = state.copyWith(productsStatus: StoreRequest.requestInProgress);
      final response = await repository.getProducts();
      state = state.copyWith(
          products: response, productsStatus: StoreRequest.requestSuccess);
    } catch (e) {
      state = state.copyWith(productsStatus: StoreRequest.requestFailure);
    }
  }

  Future<void> productsAddedToCart(int id) async {
    state = state.copyWith(cartIds: {...state.cartIds, id});
  }

  Future<void> productsRemovedFromCart(int id) async {
    state = state.copyWith(cartIds: {...state.cartIds}..remove(id));
  }
}
