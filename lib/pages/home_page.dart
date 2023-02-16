import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store/pages/controller/home_controller.dart';

import '../provider/provider.dart';
import 'controller/home_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Store Riverpod',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          Consumer(builder: (_, ref, __) {
            return IconButton(
              onPressed: () => ref.read(darkMode.notifier).state =
                  !ref.read(darkMode.notifier).state,
              icon: const Icon(
                Icons.sunny,
              ),
            );
          }),
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, __) {
            final state = ref.watch(homeNotifier);
            if (state.productsStatus == StoreRequest.requestInProgress) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state.productsStatus == StoreRequest.requestFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problema al cargar Productos'),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      // context.read<StoreBloc>().add(StoreProductsRequest());
                    },
                    child: const Text('Intenta nuevamente'),
                  ),
                ],
              );
            }

            if (state.productsStatus == StoreRequest.unknown) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shop_outlined,
                    size: 60,
                    color: Colors.black26,
                  ),
                  const SizedBox(height: 10),
                  const Text('No se encontraron productos'),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      // context.read<StoreBloc>().add(StoreProductsRequest());
                    },
                    child: const Text('Cargar productos'),
                  ),
                ],
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final inCart = state.cartIds.contains(product.id);

                return Card(
                  key: ValueKey(product.id),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Flexible(
                          child: Image.network(product.image),
                        ),
                        Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        inCart
                            ? OutlinedButton.icon(
                                icon: const Icon(
                                    Icons.remove_shopping_cart_outlined),
                                onPressed: () => ref
                                    .read(homeNotifier.notifier)
                                    .productsRemovedFromCart(product.id),
                                style: ButtonStyle(
                                  backgroundColor: inCart
                                      ? const MaterialStatePropertyAll<Color>(
                                          Colors.black12)
                                      : null,
                                ),
                                label: Text(
                                  'Eliminar del carrito',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                            : OutlinedButton.icon(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () => ref
                                    .read(homeNotifier.notifier)
                                    .productsAddedToCart(product.id),
                                style: ButtonStyle(
                                  backgroundColor: inCart
                                      ? const MaterialStatePropertyAll<Color>(
                                          Colors.black12)
                                      : null,
                                ),
                                label: Text(
                                  'Agregar al carrito',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
