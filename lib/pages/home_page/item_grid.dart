import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecshop_techpit/model/shop_item.dart';
import 'package:ecshop_techpit/pages/item_page/item_page.dart';

class ItemGrid extends ConsumerWidget {
  const ItemGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(shopItemIdsForSelectedCategoryProvider);
    return ids.when(
      loading: () => const SliverToBoxAdapter(child: Text('Loading')),
      error: (error, stack) => const SliverToBoxAdapter(child: Text('Error')),
      data: (itemIds) => SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InkWell(
                onTap: () => {
                  GoRouter.of(context).go(
                    '/${ItemPage.basePath}/${itemIds[index]}',
                  ),
                },
                child: _ItemCard(itemIds[index]),
              );
            },
            childCount: itemIds.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends ConsumerWidget {
  const _ItemCard(this.id);

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(shopItemForIdProvider(id));
    return item.when(
      loading: () => const SliverToBoxAdapter(child: Text('Loading')),
      error: (error, stack) => const SliverToBoxAdapter(child: Text('Error')),
      data: (item) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 2 * 0.8,
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 4,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '${item.price}yen',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
