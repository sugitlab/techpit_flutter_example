// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$ItemCategoryEnumMap, json['category']),
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      price: json['price'] as int,
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'category': _$ItemCategoryEnumMap[instance.category],
      'options': instance.options,
      'price': instance.price,
    };

const _$ItemCategoryEnumMap = {
  ItemCategory.shoes: 'shoes',
  ItemCategory.uniform: 'uniform',
  ItemCategory.jacket: 'jacket',
  ItemCategory.pants: 'pants',
  ItemCategory.glass: 'glass',
  ItemCategory.backpack: 'backpack',
};
