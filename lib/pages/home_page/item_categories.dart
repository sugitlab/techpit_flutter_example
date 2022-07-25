import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecshop_techpit/model/category.dart';

class ItemCategories extends ConsumerWidget {
  const ItemCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: ItemCategory.values
              .map(
                (category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () => {
                      ref.read(selectedCategoryProvider.notifier).state =
                          category,
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (selectedCategory == category)
                            ? Theme.of(context).highlightColor
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: _CategoryImage(category: category),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _CategoryImage extends ConsumerWidget {
  const _CategoryImage({super.key, required this.category});
  final ItemCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.watch(categoryIconPathProvider(category));
    return (imagePath.isEmpty)
        ? const Text('No Image')
        : Image.asset(
            imagePath,
            width: 60,
            height: 60,
          );
  }
}
