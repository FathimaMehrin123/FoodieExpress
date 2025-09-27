import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/presentation/widgets/error_widget.dart' as custom_widgets;
import '../bloc/food_bloc.dart';
import '../bloc/food_event.dart';
import '../bloc/food_state.dart';
import '../widgets/restaurant_list_widget.dart';
import '../widgets/restaurant_detail_widget.dart';
import '../widgets/order_confirmation_widget.dart';
import '../widgets/loading_widget.dart';


class FoodOrderingPage extends StatelessWidget {
  const FoodOrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodieExpress'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodInitial) {
            context.read<FoodBloc>().add(LoadRestaurants());
            return LoadingWidget();
          } else if (state is FoodLoading) {
            return LoadingWidget();
          } else if (state is RestaurantsLoaded) {
            return RestaurantListWidget(restaurants: state.restaurants);
          } else if (state is RestaurantSelected) {
            return RestaurantDetailWidget(
              restaurant: state.restaurant,
              cart: state.cart,
            );
          } else if (state is OrderPlaced) {
            return OrderConfirmationWidget(order: state.order);
          } else if (state is FoodError) {
            return custom_widgets.ErrorWidget(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}