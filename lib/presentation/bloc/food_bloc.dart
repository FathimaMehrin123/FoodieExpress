import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/domain/usecases/place_order.dart';
import '../../domain/usecases/get_restaurants.dart';
import '../../domain/entities/menu_item.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetRestaurants getRestaurants;
  final PlaceOrder placeOrder;

  final Map<MenuItem, int> _cart = {};

  FoodBloc({
    required this.getRestaurants,
    required this.placeOrder,
  }) : super(FoodInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SelectRestaurant>(_onSelectRestaurant);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<ResetWorkflow>(_onResetWorkflow);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<FoodState> emit,
  ) async {
    emit(FoodLoading());
    
   final failureOrRestaurants = await getRestaurants.call();
    
    failureOrRestaurants.fold(
      (failure) => emit(FoodError(_mapFailureToMessage(failure))),
      (restaurants) => emit(RestaurantsLoaded(restaurants)),
    );
  }

  void _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<FoodState> emit,
  ) {
    _cart.clear();
    emit(RestaurantSelected(event.restaurant, Map.from(_cart)));
  }

  void _onAddToCart(
    AddToCart event,
    Emitter<FoodState> emit,
  ) {
    if (state is RestaurantSelected) {
      final currentState = state as RestaurantSelected;
      _cart[event.menuItem] = (_cart[event.menuItem] ?? 0) + 1;
      emit(RestaurantSelected(currentState.restaurant, Map.from(_cart)));
    }
  }

  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<FoodState> emit,
  ) {
    if (state is RestaurantSelected) {
      final currentState = state as RestaurantSelected;
      if (_cart.containsKey(event.menuItem)) {
        if (_cart[event.menuItem]! > 1) {
          _cart[event.menuItem] = _cart[event.menuItem]! - 1;
        } else {
          _cart.remove(event.menuItem);
        }
      }
      emit(RestaurantSelected(currentState.restaurant, Map.from(_cart)));
    }
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<FoodState> emit,
  ) async {
    emit(FoodLoading());
    
    final failureOrOrder = await placeOrder.call(event.order);
    
    failureOrOrder.fold(
      (failure) => emit(FoodError(_mapFailureToMessage(failure))),
      (order) => emit(OrderPlaced(order)),
    );
  }

  void _onResetWorkflow(
    ResetWorkflow event,
    Emitter<FoodState> emit,
  ) {
    _cart.clear();
    emit(FoodInitial());
  }

  String _mapFailureToMessage(failure) {
    return 'Something went wrong. Please try again.';
  }
}