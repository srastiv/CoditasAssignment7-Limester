import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../data/food_network_model.dart';
import '../screens/s4_orders_page.dart';

Widget myOrderOverlay(
    BuildContext context, List<FoodNetworkHelper> selectedFoodList, totalFoodSum) {
  return SizedBox(
    width: 325,
    height: 80,
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            // offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 300),
        painter: CustomShapePainter(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: kDarkBlue,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ${selectedFoodList.length}  ",
                    style: TextStyle(
                        color: kDarkBlue, fontWeight: FontWeight.bold),
                  ),
                  kPlatesInCartText,
                ],
              ),
            ),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: CustomShapePainter(),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kDarkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(selectedFoodList, totalFoodSum),
                      ),
                    );
                  },
                  child: kMyOrderButtonText,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromARGB(211, 255, 255, 255)
      ..strokeWidth = 15;

    var path = Path();
    path.moveTo(size.width * 0.15, 0);
    //path.quadraticBezierTo(0, 0, size.width * 0.8, 0);
    path.lineTo(0, size.height * 0.85);
    //path.quadraticBezierTo(0, 0, size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.8);
    //path.quadraticBezierTo(0, 0, size.width * 0.8, 0);
    path.lineTo(size.width * 0.85, 0);
    path.lineTo(0, 0);
    // path.quadraticBezierTo(0, 0, size.width * 0.2, 0);
    canvas.drawPath(path, paint);
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.9)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 50);
  }

  @override
  bool shouldRepaint(CustomShapePainter oldDelegate) {
    return false;
  }
}
