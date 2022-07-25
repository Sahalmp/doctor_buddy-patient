import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';
import 'package:doctorbuddy/presentation/widgets/textwidgets/headtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController phnocontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
      child: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gheight_30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadingText(
                        text: 'Login',
                      ),
                      InkWell(
                        child: const Text(
                          'Are you a doctor',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          // if (!await launchUrl(Uri.parse('url'))) {
                          //   throw 'Could not launch';
                          // }
                        },
                      ),
                    ],
                  ),
                  gheight_50,
                  Center(
                    child: Image(
                      image: const AssetImage(loginimg),
                      width: devSize.width * 0.7,
                    ),
                  ),
                  gheight_30,
                  const Text(
                    'Enter the Mobile no',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  gheight_10,
                  TextFormField(
                    controller: phnocontroller,
                    decoration: const InputDecoration(
                        prefix: Text('+91 '),
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'Enter valid Mobile no';
                      }
                      return null;
                    },
                  ),
                  const Text(
                    'We will send you a one time password to this mobile number',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  gheight_30,
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            nextPage(
                                context: context,
                                page: VerificationScreen(
                                  phoneno: phnocontroller.text,
                                ));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Send OTP'),
                        ),
                      )),
                    ],
                  )
                ])),
      ),
    ));
  }
}
