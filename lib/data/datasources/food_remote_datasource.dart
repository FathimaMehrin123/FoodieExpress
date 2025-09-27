import '../models/restaurant_model.dart';
import '../models/order_model.dart';
import '../models/menu_item_model.dart';

abstract class FoodRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants();
  Future<OrderModel> placeOrder(OrderModel order);
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  // Mock data for demonstration
  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    
    // Return mock data
    return [
      RestaurantModel(
        id: '1',
        name: 'Pizza Palace',
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
        rating: 4.5,
        cuisine: 'Italian',
        deliveryTime: 30,
        deliveryFee: 2.99,
        menu: [
          MenuItemModel(
            id: '1',
            name: 'Margherita Pizza',
            description: 'Fresh tomatoes, mozzarella, basil',
            price: 12.99,
            imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400',
            isVegetarian: true,
          ),
          MenuItemModel(
            id: '2',
            name: 'Pepperoni Pizza',
            description: 'Classic pepperoni with cheese',
            price: 15.99,
            imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400',
            isVegetarian: false,
          ),
          MenuItemModel(
            id: '3',
            name: 'Veggie Supreme',
            description: 'Bell peppers, onions, mushrooms, olives',
            price: 14.99,
            imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
            isVegetarian: true,
          ),
        ],
      ),
      RestaurantModel(
        id: '2',
        name: 'Burger House',
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
        rating: 4.2,
        cuisine: 'American',
        deliveryTime: 25,
        deliveryFee: 1.99,
        menu: [
          MenuItemModel(
            id: '4',
            name: 'Classic Burger',
            description: 'Beef patty, lettuce, tomato, onion',
            price: 9.99,
            imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
            isVegetarian: false,
          ),
          MenuItemModel(
            id: '5',
            name: 'Veggie Burger',
            description: 'Plant-based patty, fresh vegetables',
            price: 8.99,
            imageUrl: 'https://images.unsplash.com/photo-1525059696034-4967a729002e?w=400',
            isVegetarian: true,
          ),
          MenuItemModel(
            id: '6',
            name: 'Cheese Fries',
            description: 'Crispy fries with melted cheese',
            price: 4.99,
            imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
            isVegetarian: true,
          ),
        ],
      ),
      RestaurantModel(
        id: '3',
        name: 'Sushi Express',
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
        rating: 4.7,
        cuisine: 'Japanese',
        deliveryTime: 40,
        deliveryFee: 3.99,
        menu: [
          MenuItemModel(
            id: '7',
            name: 'California Roll',
            description: 'Crab, avocado, cucumber',
            price: 8.99,
            imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
            isVegetarian: false,
          ),
          MenuItemModel(
            id: '8',
            name: 'Salmon Nigiri',
            description: 'Fresh salmon over rice',
            price: 12.99,
            imageUrl: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400',
            isVegetarian: false,
          ),
          MenuItemModel(
            id: '9',
            name: 'Vegetable Roll',
            description: 'Cucumber, avocado, carrot',
            price: 6.99,
            imageUrl: 'https://images.unsplash.com/photo-1617196034183-421b4917abd8?w=400',
            isVegetarian: true,
          ),
        ],
      ),
    ];
  }

  @override
  Future<OrderModel> placeOrder(OrderModel order) async {
    await Future.delayed(Duration(seconds: 2));
    // Simulate order processing
    return order;
  }
}