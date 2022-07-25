// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
class CartItem with _$CartItem {
  factory CartItem({
    required String itemId,
    required String option,
    required int count,
  }) = _CartItem;
}
