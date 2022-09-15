import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodu_app/constants/color_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../constants/text_constants.dart';
import '../constants/textstyle_constants.dart';
import 's3_fresh_menu.dart';

class EnterOTP extends StatefulWidget {
  const EnterOTP({Key? key}) : super(key: key);

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

Timer? timer;
int start = 120;

class _EnterOTPState extends State<EnterOTP> {
  startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void stopTimer() {
    setState(() => timer!.cancel());
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  TextEditingController textEditingController = TextEditingController();

  String currentText = "";
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
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kEnterOTPtext,
            Row(
              children: [
                kCheckMessageBoxText,
                const SizedBox(width: 50),
                Text(
                  '$start sec',
                  style: kTimerStyle,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              child: PinCodeTextField(
                textStyle: const TextStyle(
                  color: kLightGreen,
                ),
                length: 6,
                keyboardType: TextInputType.number,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 42,
                  inactiveColor: kLightestBlue,
                  selectedColor: kLightestBlue,
                  activeColor: kLightestBlue,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                //enableActiveFill: true,
                controller: textEditingController,
                onCompleted: (v) {
                  debugPrint("Completed");
                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
                appContext: context,
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [kDontReceiveCodeText, kResendText],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 60,
                width: 275,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    currentText.length == 6
                        ? const BoxShadow(
                            color: kDarkBlue,
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer)
                        : const BoxShadow(
                            color: Color.fromARGB(0, 255, 255, 255))
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    currentText.length == 6
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (FreshMenu()),
                            ),
                          )
                        : null;
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      primary: currentText.length == 6 ? kDarkBlue : kGrey),
                  child: kConfirmOTPtext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
