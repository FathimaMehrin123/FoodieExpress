import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/domain/entities/menu_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final int deliveryTime;
  final double deliveryFee;
  final List<MenuItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.menu,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, cuisine, deliveryTime, deliveryFee, menu];
}