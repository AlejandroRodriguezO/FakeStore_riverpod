import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/pages/controller/home_state.dart';
import 'package:store/repository/store_repository.dart';

import '../pages/controller/home_controller.dart';

final _dio = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(baseUrl: 'https://fakestoreapi.com/products'),
  ),
);
final _repository = Provider<StoreRepository>(
  (ref) => StoreRepositoryImp(
    ref.read(_dio),
  ),
);

final homeNotifier = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(
    repository: ref.read(_repository),
  ),
);

final darkMode = StateProvider<bool>((ref) => false);
