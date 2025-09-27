import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/failures.dart';
import '../entities/restaurant.dart';
import '../repositories/food_repository.dart';

class GetRestaurants {
  final FoodRepository repository;

  GetRestaurants(this.repository);

  Future<Either<Failure, List<Restaurant>>> call() async {
    return await repository.getRestaurants();
  }
}