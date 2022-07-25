import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SucceessSrcreen extends StatelessWidget {
  const SucceessSrcreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_mpodaskr.json"),
        ],
      ),
    );
  }
}
