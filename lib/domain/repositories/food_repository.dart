import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/failures.dart';
import '../entities/restaurant.dart';
import '../entities/order.dart';  

abstract class FoodRepository {
  Future<Either<Failure, List<Restaurant>>> getRestaurants();
  Future<Either<Failure, Order>> placeOrder(Order order);  // Domain Order, not dartz Order
}