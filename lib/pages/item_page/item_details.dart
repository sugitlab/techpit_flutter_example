import 'package:ecshop_techpit/model/cart.dart';
import 'package:ecshop_techpit/model/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetails extends ConsumerWidget {
  const ItemDetails({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(shopItemForIdProvider(id));
    return item.when(
      loading: () => const Text('loading'),
      error: (error, stack) => const Text('error'),
      data: (data) => Container(
        height: MediaQuery.of(context).size.height * .55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.elliptical(90, 5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ItemName(name: data.name),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: _ItemDescription(description: data.description),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _ItemPrice(price: '${data.price} yen'),
                ),
                _AddToCart(id: id, options: data.options),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  const _ItemName({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}

class _ItemPrice extends StatelessWidget {
  const _ItemPrice({required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _AddToCart extends ConsumerStatefulWidget {
  final List<String> options;
  final String id;
  const _AddToCart({required this.id, required this.options});

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends ConsumerState<_AddToCart> {
  String selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Options',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 8,
          children: widget.options
              .map(
                (op) => (op == selectedOption)
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() => selectedOption = op);
                        },
                        child: Text(op,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          setState(() => selectedOption = op);
                        },
                        child: Text(op),
                      ),
              )
              .toList(),
        ),
        Center(
          child: ElevatedButton(
            onPressed: (selectedOption.isEmpty)
                ? null
                : () => {
                      ref
                          .read(cartProvider.notifier)
                          .addItem(widget.id, selectedOption)
                    },
            child: const Text(
              'Add to Cart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
