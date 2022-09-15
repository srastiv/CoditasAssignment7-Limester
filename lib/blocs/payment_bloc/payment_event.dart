part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class PaymentLoadedEvent extends PaymentEvent {
  int totalPayment;

  final List<FoodNetworkHelper> selectedFoodList;

  FoodNetworkHelper? selectedFood;

  PaymentLoadedEvent(
      {required this.selectedFoodList,
      required this.totalPayment,
      this.selectedFood});
}

class QuantityIncrementEvent extends PaymentEvent {
  int totalPayment;
  final List<FoodNetworkHelper> selectedFoodList;
  FoodNetworkHelper selectedFood;
  int quantity;

  QuantityIncrementEvent(
      {required this.totalPayment,
      required this.selectedFoodList,
      required this.selectedFood,
      required this.quantity});
}

class QuantityDecrementEvent extends PaymentEvent {
  int totalPayment;
  int quantity;
  FoodNetworkHelper selectedFood;

  final List<FoodNetworkHelper> selectedFoodList;
  QuantityDecrementEvent(
      {required this.totalPayment,
      required this.selectedFoodList,
      required this.selectedFood,
      required this.quantity});
}
