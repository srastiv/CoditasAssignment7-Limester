import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodu_app/constants/color_constants.dart';
import '../blocs/food_bloc/food_bloc.dart';
import '../blocs/food_bloc/food_event.dart';
import '../blocs/food_bloc/food_state.dart';
import '../constants/text_constants.dart';
import '../widgets/fresh_menu_bar.dart';
import '../widgets/overlay_myorder.dart';

class FreshMenu extends StatelessWidget {
  int totalFoodSum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is APIFoodLoadedState) {
            return state.selectedFoodList.length == 0
                ? const SizedBox()
                : myOrderOverlay(context, state.selectedFoodList, totalFoodSum);
          }
          return kNoDataText;
        },
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is APIFoodInitialState) {
            BlocProvider.of<FoodBloc>(context).add(
              APIFoodFetchEvent(),
            );
            return const CircularProgressIndicator();
          } else if (state is APIFoodLoadedState) {
            return Column(
              children: [
                freshMenuBar(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: state.foodDetails.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 19,
                              crossAxisSpacing: 19,
                              childAspectRatio: 5.1 / 8.5),
                      itemBuilder: (BuildContext context, int index) {
                        debugPrint(
                            "FOOD_DETAILS_LENGTH: ${state.foodDetails.length}");
                        kLightGreen;
                        kLightestBlue;
                        return Container(
                          decoration: BoxDecoration(
                            color: state.selectedFoodList
                                    .contains(state.foodDetails[index])
                                ? Colors.white
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: state.foodDetails[index].id % 2 == 0
                              ? const EdgeInsets.only(bottom: 80)
                              : const EdgeInsets.only(top: 80),
                          child: GestureDetector(
                            onTap: (() {
                              // debugPrint(
                              //     "FOOD_DETAILS_INSTANCE: ${state.foodDetails[index].toString()}");
                              // debugPrint(
                              //     "SELECTEDFOOD_INSTANCE: ${state.selectedFood.toString()}");

                              state.selectedFoodList
                                      .contains(state.foodDetails[index])
                                  ? BlocProvider.of<FoodBloc>(context).add(
                                      RemoveFoodEvent(
                                        selectedFood: state.foodDetails[index],
                                        foodDetails: state.foodDetails,
                                      ),
                                    )
                                  : BlocProvider.of<FoodBloc>(context).add(
                                      AddFoodEvent(
                                        selectedFood: state.foodDetails[index],
                                        foodDetails: state.foodDetails,
                                      ),
                                    );
                              // state.selectedFoodList
                              //         .contains(state.foodDetails[index])
                              //     ? totalFoodSum +=
                              //         state.selectedFood!.foodPrice
                              //     : totalFoodSum -=
                              //         state.selectedFood!.foodPrice;
                              // debugPrint("THE TOTAL FOOD SUM = $totalFoodSum");
                            }),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: state.selectedFoodList
                                                  .contains(
                                                      state.foodDetails[index])
                                              ? kLightGreen
                                              : kWhite),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: const EdgeInsets.all(0.1),
                                    child: GridTile(
                                      child: Image.asset(
                                          "assets/images/food1.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  state.foodDetails[index].foodName,
                                  style: const TextStyle(
                                      color: kDarkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Per Plate \$${state.foodDetails[index].foodPrice.toString()}",
                                  style: const TextStyle(
                                    color: kDarkBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: kNoDataText);
          }
        },
      ),
    );
  }
}
