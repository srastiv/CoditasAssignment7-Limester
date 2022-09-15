import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';

Widget freshMenuBar() {
  return Container(
    padding: const EdgeInsets.all(30),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            menuBar(),
            const SizedBox(width: 30),
            kFreshMenuText,
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.arrow_drop_down, color: kDarkBlue, size: 27),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Container menuBar() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          //  offset: Offset(0, 5),
          blurStyle: BlurStyle.solid,
          blurRadius: 5,
          color: Color.fromARGB(142, 219, 214, 214),
        )
      ],
      border: Border.all(color: kLightestBlue, width: 3),
      borderRadius: BorderRadius.circular(20),
    ),
    height: 60,
    width: 60,
    child: IconButton(
        icon: const Icon(
          Icons.menu,
          color: kDarkBlue,
        ),
        onPressed: () {}),
  );
}
