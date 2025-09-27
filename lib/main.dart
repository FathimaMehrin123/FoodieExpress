import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/domain/usecases/place_order.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/datasources/food_remote_datasource.dart';
import 'data/repositories/food_repository_impl.dart';
import 'domain/usecases/get_restaurants.dart';
import 'presentation/bloc/food_bloc.dart';
import 'presentation/pages/food_ordering_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodBloc>(
          create: (context) => FoodBloc(
            getRestaurants: GetRestaurants(
              FoodRepositoryImpl(
                remoteDataSource: FoodRemoteDataSourceImpl(),
              ),
            ),
            placeOrder: PlaceOrder(
              FoodRepositoryImpl(
                remoteDataSource: FoodRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'FoodieExpress',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FoodOrderingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}