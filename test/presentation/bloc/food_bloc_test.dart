import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:food_delivery_app/core/errors/failures.dart';
import 'package:food_delivery_app/domain/usecases/get_restaurants.dart';
import 'package:food_delivery_app/domain/usecases/place_order.dart';
import 'package:food_delivery_app/presentation/bloc/food_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/food_event.dart';
import 'package:food_delivery_app/presentation/bloc/food_state.dart';
import 'package:food_delivery_app/domain/entities/restaurant.dart';
import 'package:food_delivery_app/domain/entities/menu_item.dart';


class MockGetRestaurants extends Mock implements GetRestaurants {}
class MockPlaceOrder extends Mock implements PlaceOrder {}

void main() {
  late FoodBloc bloc;
  late MockGetRestaurants mockGetRestaurants;
  late MockPlaceOrder mockPlaceOrder;

  final testRestaurant = Restaurant(
    id: '1', 
    name: 'Test Restaurant', 
    imageUrl: 'test.jpg',
    rating: 4.5,
    cuisine: 'Italian', 
    deliveryTime: 30,
    deliveryFee: 2.0,
    menu: [
      MenuItem(
        id: '1',
        name: 'Pizza',
        description: 'Test pizza',
        price: 12.99,
        imageUrl: 'pizza.jpg',
        isVegetarian: true,
      ),
    ],
  );

  setUp(() {
    mockGetRestaurants = MockGetRestaurants();
    mockPlaceOrder = MockPlaceOrder();
    bloc = FoodBloc(
      getRestaurants: mockGetRestaurants,
      placeOrder: mockPlaceOrder,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be FoodInitial', () {
    expect(bloc.state, equals(FoodInitial()));
  });

  group('LoadRestaurants', () {
    blocTest<FoodBloc, FoodState>(
      'emits [FoodLoading, RestaurantsLoaded] when successful',
      build: () {
        when(() => mockGetRestaurants.call())
            .thenAnswer((_) async => Right([testRestaurant]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        FoodLoading(),
        RestaurantsLoaded([testRestaurant]),
      ],
    );

    blocTest<FoodBloc, FoodState>(
      'emits [FoodLoading, FoodError] when fails',
      build: () {
        when(() => mockGetRestaurants.call())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        FoodLoading(),
        FoodError('Something went wrong. Please try again.'),
      ],
    );
  });

  group('SelectRestaurant', () {
    blocTest<FoodBloc, FoodState>(
      'emits RestaurantSelected with empty cart',
      build: () => bloc,
      act: (bloc) => bloc.add(SelectRestaurant(testRestaurant)),
      expect: () => [
        RestaurantSelected(testRestaurant, {}),
      ],
    );
  });

  group('Cart Management', () {
    blocTest<FoodBloc, FoodState>(
      'adds item to cart',
      build: () => bloc,
      seed: () => RestaurantSelected(testRestaurant, {}),
      act: (bloc) => bloc.add(AddToCart(testRestaurant.menu[0])),
      expect: () => [
        RestaurantSelected(testRestaurant, {testRestaurant.menu[0]: 1}),
      ],
    );
  });

  blocTest<FoodBloc, FoodState>(
    'resets workflow',
    build: () => bloc,
    act: (bloc) => bloc.add(ResetWorkflow()),
    expect: () => [FoodInitial()],
  );
}