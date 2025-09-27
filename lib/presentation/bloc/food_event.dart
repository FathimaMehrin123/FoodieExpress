import 'package:equatable/equatable.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/order.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends FoodEvent {}

class SelectRestaurant extends FoodEvent {
  final Restaurant restaurant;
  const SelectRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class AddToCart extends FoodEvent {
  final MenuItem menuItem;
  const AddToCart(this.menuItem);

  @override
  List<Object> get props => [menuItem];
}

class RemoveFromCart extends FoodEvent {
  final MenuItem menuItem;
  const RemoveFromCart(this.menuItem);

  @override
  List<Object> get props => [menuItem];
}

class PlaceOrderEvent extends FoodEvent {
  final Order order;
  const PlaceOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class ResetWorkflow extends FoodEvent {}