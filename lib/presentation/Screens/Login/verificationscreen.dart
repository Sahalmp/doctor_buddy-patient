import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/application/details/details_bloc.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:doctorbuddy/presentation/Screens/Login/widgets/pinput.dart';
import 'package:doctorbuddy/presentation/Screens/Mainscreen/mainscreen.dart';
import 'package:doctorbuddy/presentation/Screens/registration/adddetails.dart';
import 'package:doctorbuddy/presentation/widgets/textwidgets/headtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/Home/home_bloc.dart';
import '../../widgets/navigation/backbutton.dart';
import '../../widgets/navigation/nextpage.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class VerificationScreen extends StatefulWidget {
  final String phoneno;
  const VerificationScreen({Key? key, required this.phoneno}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String verificationCode = '';
  int secondsRemaining = 60;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
        child: ListView(
          children: [
            const BackButtonWidget(),
            gheight_10,
            const HeadingText(text: 'OTP Verification'),
            gheight_50,
            Center(
              child: Image(
                image: const AssetImage(otpimg),
                width: devSize.width * 0.7,
              ),
            ),
            gheight_50,
            Text(
                "We have send your one time password to ******${widget.phoneno.substring(6, 10)}",
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center),
            gheight_30,
            FilledRoundedPinPut(),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                print(state.enabled);
                return !state.enabled
                    ? Text(
                        ' Please wait for ${state.sec}  to Resend OTP',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        textDirection: TextDirection.rtl,
                      )
                    : InkWell(
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        onTap: _resendCode,
                      );
              },
            ),
            gheight_30,
            Row(
              children: [
                Expanded(child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          context
                              .read<HomeBloc>()
                              .add(Getloading(loading: true));
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationCode,
                                      smsCode: savedpin))
                              .then((value) async {
                            if (value.user != null) {
                              await firestore
                                  .collection('pusers')
                                  .doc(value.user!.uid)
                                  .get()
                                  .then((doc) {
                                if (doc.exists) {
                                  nextPage(
                                      context: context, page: MainScreen());
                                  context
                                      .read<HomeBloc>()
                                      .add(const Getloading(loading: false));
                                } else {
                                  nextPage(
                                      context: context, page: AddDetails());
                                }
                                context
                                    .read<HomeBloc>()
                                    .add(const Getloading(loading: false));
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Login Successful'),
                              ));
                            }
                          });
                        } catch (e) {
                          context
                              .read<HomeBloc>()
                              .add(const Getloading(loading: false));

                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Invalid otp'),
                          ));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: state.loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: whiteColor,
                                      backgroundColor: primary,
                                    ),
                                  ),
                                  gwidth_10,
                                  Text("Logging in"),
                                ],
                              )
                            : const Text('Submit'),
                      ),
                    );
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  verifyphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneno}',
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationCode = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: const Duration(seconds: 60));
  }

  @override
  void initState() {
    verifyphone();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        BlocProvider.of<HomeBloc>(context)
            .add(Gettimerseconds(sec: secondsRemaining--));
      } else {
        BlocProvider.of<HomeBloc>(context)
            .add(const Getenabledtimer(enabled: true));
      }
    });
    super.initState();
  }

  void _resendCode() {
    //other code here
    verifyphone();

    secondsRemaining = 60;

    BlocProvider.of<HomeBloc>(context)
        .add(Gettimerseconds(sec: secondsRemaining));
    BlocProvider.of<HomeBloc>(context)
        .add(const Getenabledtimer(enabled: false));
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }
}
