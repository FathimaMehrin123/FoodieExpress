import 'package:dartz/dartz.dart' hide Order;
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/order.dart'; 
import '../../domain/repositories/food_repository.dart';
import '../datasources/food_remote_datasource.dart';
import '../models/order_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource remoteDataSource;

  FoodRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurants() async {
    try {
      final restaurants = await remoteDataSource.getRestaurants();
      return Right(restaurants);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Order>> placeOrder(Order order) async {  // Domain Order
    try {
      final orderModel = OrderModel.fromEntity(order);
      final result = await remoteDataSource.placeOrder(orderModel);
      return Right(result);  // This should return domain Order
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to place order'));
    }
  }
}