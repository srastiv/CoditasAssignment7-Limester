import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/food_network_model.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitialState()) {
    on<QuantityIncrementEvent>(
      (event, emit) {
        if (event.selectedFood.quantity < 9) {
          event.selectedFood.quantity++;
        }
        event.totalPayment = event.totalPayment +
              event.selectedFood.foodPrice * event.selectedFood.quantity;
        // event.totalPayment = event.selectedFoodList.reduce((sum, element) {
        //       return sum;
        //     }).foodPrice *
        //     event.selectedFood.quantity;
        emit(
          FoodQuantityState(
              selectedFood: event.selectedFood,
              quantity: event.selectedFood.quantity,
              selectedFoodList: event.selectedFoodList,
              totalPayment: event.totalPayment),
        );
      },
    );
    on<QuantityDecrementEvent>(
      (event, emit) {
        if (event.selectedFood.quantity > 0) {
          event.selectedFood.quantity--;
          event.totalPayment = event.totalPayment +
              event.selectedFood.foodPrice * event.selectedFood.quantity;
          // event.totalPayment = event.selectedFoodList.reduce((sum, element) {
          //       return sum;
          //     }).foodPrice *
          //     event.selectedFood.quantity;
          emit(
            FoodQuantityState(
                selectedFood: event.selectedFood,
                quantity: event.selectedFood.quantity,
                selectedFoodList: event.selectedFoodList,
                totalPayment: event.totalPayment),
          );
        }
      },
    );
    on<PaymentLoadedEvent>(
      (event, emit) {
        emit(
          FoodQuantityState(
              selectedFood: event.selectedFood,
              quantity: event.selectedFood!.quantity,
              selectedFoodList: event.selectedFoodList,
              totalPayment: event.totalPayment),
        );
      },
    );
  }
}
