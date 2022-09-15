part of 'payment_bloc.dart';

@immutable
abstract class PaymentState {}

class PaymentInitialState extends PaymentState {}

class PaymentLoadedState extends PaymentState {}

class FoodQuantityState extends PaymentState {
  int totalPayment;
  int quantity;
  FoodNetworkHelper? selectedFood;
  final List<FoodNetworkHelper>? selectedFoodList;
  FoodQuantityState(
      {required this.selectedFoodList,
      required this.totalPayment,
      required this.quantity,
      this.selectedFood});
}
