import 'package:ecshop_techpit/model/shop_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecshop_techpit/model/data/cart_item/cart_item.dart';

typedef Cart = List<CartItem>;

final cartProvider = StateNotifierProvider<CartNotifier, Cart>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super([]);

  void addItem(String id, String option) {
    state = [
      ...state,
      CartItem(itemId: id, option: option, count: 1),
    ];
  }

  void removeItem(String id, String option) {
    state = state
        .where((item) => !(item.itemId == id && item.option == option))
        .toList();
  }

  void incrementItemCount(String id, String option) {
    state = [
      for (final item in state)
        if (item.itemId == id && item.option == option)
          CartItem(
            itemId: item.itemId,
            option: item.option,
            count: item.count + 1,
          )
        else
          item,
    ];
  }

  void decrementItemCount(String id, String option) {
    state = [
      for (final item in state)
        if (item.itemId == id && item.option == option)
          CartItem(
            itemId: item.itemId,
            option: item.option,
            count: (item.count > 1) ? item.count - 1 : item.count,
          )
        else
          item,
    ];
  }
}

final cartItemCountProvider = Provider((ref) => ref.watch(cartProvider).length);

final totalPriceProvider = Provider((ref) {
  return ref.watch(cartProvider).fold<int>(0, (prev, el) {
    return prev +
        el.count * ref.watch(shopItemForIdProvider(el.itemId)).value!.price;
  });
});
