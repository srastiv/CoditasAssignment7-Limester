import '../../data/food_network_model.dart';

abstract class FoodState {}

class APIFoodInitialState extends FoodState {}

class APIFoodLoadedState extends FoodState {
  final List<FoodNetworkHelper> foodDetails;
  final FoodNetworkHelper? selectedFood;
  final List<FoodNetworkHelper> selectedFoodList;

  APIFoodLoadedState(
      {required this.foodDetails, this.selectedFood, required this.selectedFoodList});
}