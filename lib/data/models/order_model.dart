import 'package:uuid/uuid.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu_item.dart';
import 'restaurant_model.dart';
import 'menu_item_model.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.menuItem,
    required super.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      menuItem: MenuItemModel.fromJson(json['menuItem']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuItem': (menuItem as MenuItemModel).toJson(),
      'quantity': quantity,
    };
  }
}

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.restaurant,
    required super.items,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
    required super.orderTime,
  });

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      restaurant: order.restaurant,
      items: order.items,
      subtotal: order.subtotal,
      deliveryFee: order.deliveryFee,
      total: order.total,
      orderTime: order.orderTime,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      restaurant: RestaurantModel.fromJson(json['restaurant']),
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      subtotal: json['subtotal'].toDouble(),
      deliveryFee: json['deliveryFee'].toDouble(),
      total: json['total'].toDouble(),
      orderTime: DateTime.parse(json['orderTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant': (restaurant as RestaurantModel).toJson(),
      'items': items.map((item) => (item as OrderItemModel).toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'orderTime': orderTime.toIso8601String(),
    };
  }

  static OrderModel createNew({
    required Restaurant restaurant,
    required Map<MenuItem, int> cartItems,
  }) {
    final items = cartItems.entries
        .map((entry) => OrderItemModel(
              menuItem: entry.key,
              quantity: entry.value,
            ))
        .toList();

    final subtotal = items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );

    final deliveryFee = restaurant.deliveryFee;
    final total = subtotal + deliveryFee;

    return OrderModel(
      id: const Uuid().v4(),
      restaurant: restaurant,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
      orderTime: DateTime.now(),
    );
  }
}