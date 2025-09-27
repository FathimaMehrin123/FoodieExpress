import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/failures.dart';
import '../entities/order.dart';
import '../repositories/food_repository.dart';

class PlaceOrder {
  final FoodRepository repository;

  PlaceOrder(this.repository);

  Future<Either<Failure, Order>> call(Order order) async {
    return await repository.placeOrder(order);
  }
}