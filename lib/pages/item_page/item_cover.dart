import 'package:ecshop_techpit/model/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCover extends ConsumerWidget {
  const ItemCover({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(
      shopItemForIdProvider(id).select(
        (value) => value.whenData((data) => data.imageUrl),
      ),
    );
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: image.when(
            loading: () => const Text('loading'),
            error: (error, trace) => const Text('error'),
            data: (data) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                data,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
