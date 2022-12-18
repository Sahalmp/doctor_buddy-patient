import 'dart:async';

import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/presentation/Screens/Mainscreen/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/datafetch/data_bloc.dart';
import '../Login/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

double width = 0.5;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final cauth = FirebaseAuth.instance.currentUser;
    BlocProvider.of<DataBloc>(context).add(Getdata());

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    cauth == null ? LoginScreen() : MainScreen())));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        width = 0.7;
      });
    });
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: AnimatedContainer(
          width: MediaQuery.of(context).size.width * width,
          duration: const Duration(seconds: 1),
          child: const Image(image: AssetImage('asset/images/splash.png')),
        ),
      ),
    );
  }
}
