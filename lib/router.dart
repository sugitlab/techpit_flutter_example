import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecshop_techpit/pages/home_page/home_page.dart';
import 'package:ecshop_techpit/pages/item_page/item_page.dart';
import 'package:ecshop_techpit/pages/cart_page/cart_page.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/', //HomePage.path,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: CartPage.path,
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            path: ItemPage.path,
            builder: (context, state) => ItemPage(
              id: state.params[ItemPage.param]!,
            ),
          ),
        ],
      ),
    ],
  ),
);
