import 'package:flutter/material.dart';
import 'package:foodu_app/constants/color_constants.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //floatingActionButton: MyOrderOverlay(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/chef.png"),
          ),
          const Text(
            "Chef is preparing your food...",
            style: TextStyle(
                color: kDarkBlue, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Please do some stretching until ",
                  style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: "\n   chef is preparing your food...",
                  style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Container(
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: CustomShapePainter(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Back to",
                          style: TextStyle(color: kDarkBlue, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 21),
                  Icon(Icons.home),
                  SizedBox(width: 40),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 300),
                    painter: CustomShapePainter(),
                    child: Container(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kDarkBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => OrdersPage())));
                        },
                        child: const Text(
                          "Track Order",
                          style: TextStyle(color: kWhite, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color.fromARGB(211, 255, 255, 255)
      ..strokeWidth = 15;

    var path = Path();
    path.moveTo(size.width * 0.15, 0);
    path.lineTo(0, size.height * 0.85);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.85, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomShapePainter oldDelegate) {
    return false;
  }
}
