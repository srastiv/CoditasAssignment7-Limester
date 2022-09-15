import 'package:foodu_app/data/food_network_model.dart';

abstract class FoodEvent {}

class APIFoodFetchEvent extends FoodEvent {}


class AddFoodEvent extends FoodEvent {
  FoodNetworkHelper selectedFood;
  final List<FoodNetworkHelper> foodDetails;

  AddFoodEvent({required this.selectedFood, required this.foodDetails});
}

class RemoveFoodEvent extends FoodEvent {
  FoodNetworkHelper selectedFood;
  final List<FoodNetworkHelper> foodDetails;

  RemoveFoodEvent({required this.selectedFood, required this.foodDetails});
}

// class FoodSelectedOrNotEvent extends FoodEvent {
//   FoodNetworkHelper selectedFood;
//   FoodSelectedOrNotEvent({required this.selectedFood});
// }


