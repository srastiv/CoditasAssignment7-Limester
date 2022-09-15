import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/food_network_model.dart';
import '../../data/network_helper.dart';
import '../food_bloc/food_event.dart';
import '../food_bloc/food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(APIFoodInitialState()) {
    List<FoodNetworkHelper> selectedFoodList = [];
    on<APIFoodFetchEvent>(
      (event, emit) async {
        var foodDetails = await getFoodData();
        emit(
          APIFoodLoadedState(
           
            foodDetails: foodDetails,
            selectedFoodList: selectedFoodList,
          ),
        );
      },
    );
    on<AddFoodEvent>(
      (event, emit) {
        selectedFoodList.add(event.selectedFood);
        debugPrint("Add food event - SELECTED_FOOD_LIST: $selectedFoodList");
       
        emit(
          APIFoodLoadedState(
            foodDetails: event.foodDetails,
            selectedFoodList: selectedFoodList,
            selectedFood: event.selectedFood,
          ),
        );
      },
    );
    on<RemoveFoodEvent>(
      (event, emit) {
        if (selectedFoodList.contains(event.selectedFood)) {
          selectedFoodList.remove(event.selectedFood);
        }
        emit(
          APIFoodLoadedState(
             foodDetails: event.foodDetails,
            selectedFoodList: selectedFoodList,
            selectedFood: event.selectedFood,
          ),
        );
      },
    );
   
  }
}
