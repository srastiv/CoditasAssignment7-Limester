import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import 's2_enter_otp.dart';

class LimesterMobileRegistration extends StatefulWidget {
  const LimesterMobileRegistration({Key? key}) : super(key: key);

  @override
  State<LimesterMobileRegistration> createState() =>
      _LimesterMobileRegistrationState();
}

class _LimesterMobileRegistrationState
    extends State<LimesterMobileRegistration> {
  List<String> countryCodes = ['+91', '+44', '+1', '+52', '+86', "+99"];
  String? selectedCountryCode;

  TextEditingController tc = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 300,
              ),
              Image.asset("assets/images/lime.png"),
              Text(
                "Limester",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: kDarkBlue,
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[kIntroText, kEatGoodText],
                  style: TextStyle(color: kLightBlue, fontSize: 17),
                ),
              ),
              const SizedBox(height: 42),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 10,
                      style: TextStyle(color: kBlack),
                      validator: (phoneNumberText) {
                        if (phoneNumberText == null ||
                            phoneNumberText.isEmpty) {
                          return 'Phone Number is empty';
                        }

                        return null;
                      },
                      controller: tc,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        isDense: true,
                        prefix: DropdownButton(
                          alignment: Alignment.center,
                          hint: const Text(
                            "+91",
                            style: TextStyle(color: kBlack),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: kBlack,
                          ),
                          elevation: 0,
                          value: selectedCountryCode,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCountryCode = newValue.toString();
                            });
                          },
                          items: countryCodes.map((code) {
                            return DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                        ),
                        prefixIcon: Image.asset("assets/images/india.png"),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: const BorderSide(
                            color: kLightestBlue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            width: 2,
                            color: kLightestBlue,
                          ),
                        ),
                        hintText: "Mobile Number",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        primary: kDarkBlue,
                      ),
                      onPressed: () {
                        final isValidForm = formKey.currentState!.validate();
                        if (isValidForm) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (EnterOTP()),
                            ),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
