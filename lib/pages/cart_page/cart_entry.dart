import 'package:ecshop_techpit/model/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecshop_techpit/model/cart.dart';
import 'package:ecshop_techpit/model/data/cart_item/cart_item.dart';

class CartEntry extends ConsumerWidget {
  const CartEntry({required this.cartItem, super.key});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemInfo = ref.watch(shopItemForIdProvider(cartItem.itemId)).value!;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              itemInfo.imageUrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemInfo.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text('Option - ${cartItem.option}'),
                Text(
                  '${itemInfo.price} yen',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _ItemCounter(cartItem: cartItem),
                    TextButton(
                        onPressed: () {
                          ref
                              .read(cartProvider.notifier)
                              .removeItem(cartItem.itemId, cartItem.option);
                        },
                        child: const Text('Delete')),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCounter extends ConsumerWidget {
  const _ItemCounter({required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: TextButton(
            onPressed: cartItem.count > 1
                ? () {
                    ref
                        .watch(cartProvider.notifier)
                        .decrementItemCount(cartItem.itemId, cartItem.option);
                  }
                : null,
            child: const Text('-'),
          ),
        ),
        Text('${cartItem.count}'),
        SizedBox(
          width: 30,
          child: TextButton(
            onPressed: () {
              ref
                  .watch(cartProvider.notifier)
                  .incrementItemCount(cartItem.itemId, cartItem.option);
            },
            child: const Text('+'),
          ),
        ),
      ],
    );
  }
}
