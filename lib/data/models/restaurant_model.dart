import '../../domain/entities/restaurant.dart';
import 'menu_item_model.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.rating,
    required super.cuisine,
    required super.deliveryTime,
    required super.deliveryFee,
    required List<MenuItemModel> super.menu,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      cuisine: json['cuisine'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'].toDouble(),
      menu: (json['menu'] as List)
          .map((item) => MenuItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'cuisine': cuisine,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'menu': menu.map((item) => (item as MenuItemModel).toJson()).toList(),
    };
  }
}