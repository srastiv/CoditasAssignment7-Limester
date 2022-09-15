import 'package:flutter/material.dart';
import 'package:foodu_app/constants/color_constants.dart';
import 'package:foodu_app/data/food_network_model.dart';
import 'package:foodu_app/data/network_helper.dart';
import 'package:foodu_app/screens/s1_mobile_registration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/food_bloc/food_bloc.dart';
import 'blocs/payment_bloc/payment_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodBloc>(
          create: (BuildContext context) => FoodBloc(),
        ),
        BlocProvider<PaymentBloc>(
          create: (BuildContext context) => PaymentBloc(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primaryColor: kDarkBlue,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          home: FutureBuilder<List<FoodNetworkHelper>>(
            future: getFoodData(),
            builder:
                (context, AsyncSnapshot<List<FoodNetworkHelper>> snapshot) {
              if (snapshot.hasData) {
                return const LimesterMobileRegistration();
              } else if (snapshot.hasError) {
                return const Text("error");
              } else
                return const Center(
                  child: CircularProgressIndicator(),
                );
            },
          )),
    );
  }
}
