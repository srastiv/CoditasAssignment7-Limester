import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodu_app/constants/text_constants.dart';
import 'package:foodu_app/screens/s5_track_order.dart';
import '../blocs/payment_bloc/payment_bloc.dart';
import '../constants/color_constants.dart';
import '../constants/textstyle_constants.dart';
import '../data/food_network_model.dart';

class OrdersPage extends StatelessWidget {
  List<FoodNetworkHelper> selectedFoodList;
  OrdersPage(this.selectedFoodList, this.totalFoodSum);
  int totalFoodSum;
  @override
  Widget build(BuildContext context) {
    debugPrint(
        "FOODLIST LENGTH ON ORDERS PAGE = ${selectedFoodList.length.toString()}");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        title: kBackText,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: kDarkBlue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 671,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/bigplate.png",
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 85,
                    child: Image.asset(
                      "assets/images/smallplate.png",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "My Orders",
                    style: TextStyle(
                        color: kDarkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: MediaQuery.of(context).size.height - 780,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        CircleAvatar(
                          backgroundColor: kWhite,
                          child: Image.asset("assets/images/applycoupon.png"),
                        ),
                        kApplyCouponText,
                        const SizedBox(
                          width: 100,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: kDarkBlue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// CONTAINER WITH FOOD INSTANCE AND PAYMENT DETAILS
                  /// BLOC IMPLEMENTATION FOR THIS CONTAINER STARTS FROM HERE

                  BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                    if (state is PaymentInitialState) {
                      BlocProvider.of<PaymentBloc>(context).add(
                        PaymentLoadedEvent(
                            selectedFood: selectedFoodList.first,
                            selectedFoodList: selectedFoodList,
                            totalPayment:
                                selectedFoodList.reduce((sum, element) {
                              return sum;
                            }).foodPrice),
                      );
                      return const Text("food is loading...");
                    } else if (state is FoodQuantityState) {
                      return Container(
                        color: kWhite,
                        child: Column(
                          children: [
                            ...selectedFoodList.map((e) {
                              return ListTile(
                                leading: IconButton(
                                  icon: Image.asset(
                                    "assets/images/circle.png",
                                  ),
                                  onPressed: () {},
                                ),
                                title: Text(
                                  e.foodName,
                                  style: kSelectedFoodItemStyle,
                                ),
                                subtitle: Text(
                                  "Per Plate \$${e.foodPrice}",
                                  style: kPerPlatePriceStyle,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 140,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          color: kLightestGreen),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<PaymentBloc>(
                                                        context)
                                                    .add(
                                                  QuantityDecrementEvent(
                                                      selectedFood: e,
                                                      quantity: state
                                                          .selectedFood!
                                                          .quantity,
                                                      totalPayment:
                                                          state.totalPayment,
                                                      selectedFoodList:
                                                          selectedFoodList),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                fixedSize: const Size(0, 0),
                                                primary: kWhite,
                                                elevation: 0,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: kBlack,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            e.quantity.toString(),
                                            style: kCountStyle,
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<PaymentBloc>(
                                                        context)
                                                    .add(
                                                  QuantityIncrementEvent(
                                                      selectedFood: e,
                                                      quantity: state
                                                          .selectedFood!
                                                          .quantity,
                                                      totalPayment:
                                                          state.totalPayment,
                                                      selectedFoodList:
                                                          selectedFoodList),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(0, 0),
                                                shape: const CircleBorder(),
                                                primary: kWhite,
                                                elevation: 0,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: kBlack,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text("\$${e.foodPrice * e.quantity}",
                                        style: kCartFoodStyle),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      kItemTotalText,
                                      const SizedBox(width: 205),
                                      ///
                                      ///TODO: IMPLEMENT TOTAL ITEMS COST HERE
                                      ///
                                      Text(
                                        "\$${state.totalPayment}",
                                        style: kPerPlatePriceStyle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: const [
                                      kDeliveryFeeText,
                                      SizedBox(width: 198),
                                      kDeliveryFee01Text
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: const [
                                      kTaxChargesText,
                                      SizedBox(width: 182),
                                      kTaxCharges01Text
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      kToPayText,
                                      const SizedBox(
                                        width: 185,
                                      ),

                                      ///
                                      ///   //TODO: IMPLEMENT TO PAY COST HERE
                                      ///
                                      Text(
                                        "\$${state.totalPayment + 2}",
                                        style: kTotalPaymentStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else
                      return const Text("error");
                  }),

                  /// THE CONTAINER ENDS HERE
                  /// BLOC ENDS HERE

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    color: kWhite,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            kDeliveryAddressText,
                            const SizedBox(
                              width: 77,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackOrder(),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  kOfficeText,
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: kLightGreen,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kLightestGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                        kAddressText
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
