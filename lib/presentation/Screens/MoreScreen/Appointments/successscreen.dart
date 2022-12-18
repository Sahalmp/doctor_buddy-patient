import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:doctorbuddy/presentation/Screens/Mainscreen/mainscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/status.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../domain/colors.dart';
import '../../../../domain/constants.dart';

class SucceessSrcreen extends StatelessWidget {
  const SucceessSrcreen(
      {Key? key,
      required this.data,
      required this.timing,
      required this.hospitalvalue,
      required this.date,
      required this.payment,
      required this.fee,
      required this.token})
      : super(key: key);
  final DocumentSnapshot data;
  final String timing;
  final String hospitalvalue;
  final String date;
  final int token;
  final payment;
  final fee;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushRemove(context: context, page: MainScreen());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            body: ListView(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pushRemove(context: context, page: MainScreen());
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
              gheight_10,
              Card(
                  color: whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: background,
                          radius: 65,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        ),
                        gwidth_10,
                        Text(
                          "Dr. ${data['name']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: primary,
                              fontSize: 18),
                        ),
                        Text("${data['category']}"),
                        gheight_20,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: background)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                AppointmentStatusTimeWidget(
                                  type: 'Hospital:',
                                  value: hospitalvalue,
                                ),
                                AppointmentStatusTimeWidget(
                                  type: 'Timing:',
                                  value: timing,
                                ),
                                AppointmentStatusTimeWidget(
                                  type: 'Appointmentdate:',
                                  value: date,
                                ),
                                AppointmentStatusTimeWidget(
                                  type: 'Token:',
                                  value: '$token',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Lottie.network(
                            "https://assets2.lottiefiles.com/packages/lf20_mpodaskr.json"),
                        payment == null
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: background)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: const [
                                      AppointmentStatusTimeWidget(
                                        type: 'Payment:',
                                        value: 'Paid through Wallet',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: background)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      AppointmentStatusTimeWidget(
                                        type: 'Payment Id:',
                                        value: '${payment.paymentId}',
                                      ),
                                      AppointmentStatusTimeWidget(
                                        type: 'amount:',
                                        value: '$fee',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ))
            ]),
          ],
        )),
      ),
    );
  }
}
