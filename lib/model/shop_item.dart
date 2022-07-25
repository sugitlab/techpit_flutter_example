import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show rootBundle;
// import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecshop_techpit/model/data/item/item.dart';
import 'package:ecshop_techpit/model/category.dart';

final shopItemProvider = FutureProvider((ref) async {
  final data = await rootBundle.loadString('assets/mock.json');
  // final result = await Client().get(Uri.parse(
  //    'https://run.mocky.io/v3/9969a48c-5741-4421-91ca-1517049eb893'));
  final json = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
  final items = json.map(Item.fromJson).toList();
  return items;
});

final shopItemIdsForSelectedCategoryProvider = Provider((ref) {
  final AsyncValue<List<Item>> items = ref.watch(shopItemProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  return items.whenData((items) => items
      .where((item) => item.category == selectedCategory)
      .map((item) => item.id)
      .toList());
});

final shopItemForIdProvider = Provider.family((ref, String id) {
  final AsyncValue<List<Item>> items = ref.watch(shopItemProvider);
  return items.whenData((items) => items.firstWhere((item) => item.id == id));
});
