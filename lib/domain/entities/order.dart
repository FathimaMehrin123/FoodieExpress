import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/domain/entities/menu_item.dart';
import 'package:food_delivery_app/domain/entities/restaurant.dart';

class Order extends Equatable {
  final String id;
  final Restaurant restaurant;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime orderTime;

  const Order({
    required this.id,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.orderTime,
  });

  @override
  List<Object> get props => [id, restaurant, items, subtotal, deliveryFee, total, orderTime];
}

class OrderItem extends Equatable {
  final MenuItem menuItem;
  final int quantity;

  const OrderItem({
    required this.menuItem,
    required this.quantity,
  });

  double get totalPrice => menuItem.price * quantity;

  @override
  List<Object> get props => [menuItem, quantity];
}