import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';


var savedpin;

class FilledRoundedPinPut extends StatelessWidget {
  FilledRoundedPinPut({Key? key}) : super(key: key);

  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromARGB(255, 226, 21, 58);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 55,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 58,
      child: Pinput(
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        submittedPinTheme: PinTheme(
            width: 46,
            height: 55,
            textStyle: GoogleFonts.poppins(
              fontSize: 22,
              color: Color.fromRGBO(30, 60, 87, 1),
            ),
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            )),
        length: 6,
        controller: controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) async {
          // showError = pin != '55555';
          savedpin = pin;
          focusNode.hasFocus;
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 58,
          width: 54,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
