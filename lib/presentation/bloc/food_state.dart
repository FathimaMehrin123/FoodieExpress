import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/order.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class RestaurantsLoaded extends FoodState {
  final List<Restaurant> restaurants;
  const RestaurantsLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantSelected extends FoodState {
  final Restaurant restaurant;
  final Map<MenuItem, int> cart;
  
  const RestaurantSelected(this.restaurant, this.cart);

  @override
  List<Object> get props => [restaurant, cart];
}

class OrderPlaced extends FoodState {
  final Order order;
  const OrderPlaced(this.order);

  @override
  List<Object> get props => [order];
}

class FoodError extends FoodState {
  final String message;
  const FoodError(this.message);

  @override
  List<Object> get props => [message];
}