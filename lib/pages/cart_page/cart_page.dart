import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecshop_techpit/pages/cart_page/cart_entry.dart';
import 'package:ecshop_techpit/model/cart.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const path = 'cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: ref.watch(cartItemCountProvider) > 0
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) => CartEntry(
                          cartItem: cart.elementAt(index),
                        )),
                    itemCount: ref.watch(cartItemCountProvider),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('${ref.watch(totalPriceProvider)} yen - Buy'),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'No Item',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Container(),
              ],
            ),
    );
  }
}
