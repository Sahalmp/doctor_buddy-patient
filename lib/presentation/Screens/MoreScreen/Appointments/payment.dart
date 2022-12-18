import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/loadingpage.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/successscreen.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../application/details/details_bloc.dart';
import '../../../../domain/appointment/appointment.dart';
import '../../../../infastructure/datafetch/notification.dart';

class Paymentwidget extends StatefulWidget {
  const Paymentwidget({
    Key? key,
    required this.wallet,
    required this.wmoney,
    required this.appfee,
    required this.reason,
    required this.doc,
    required this.timing,
    required DateTime selectedValue,
  })  : _selectedValue = selectedValue,
        super(key: key);
  final String timing, appfee;
  final String reason;
  final bool wallet;
  final int wmoney;
  final DateTime _selectedValue;
  final doc;

  @override
  State<Paymentwidget> createState() => _PaymentwidgetState();
}

class _PaymentwidgetState extends State<Paymentwidget> {
  Razorpay? razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = Razorpay();

    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay?.clear();
  }

  void openCheckout(amount) {
    var options = {
      "key": "rzp_test_BUioCj49iOdN9h",
      'timeout': 60 * 5,
      "amount": num.parse(amount) * 100,
      "name": "DoctorBuddy",
      "description": "Appointment ",
      "prefill": {"contact": "2323232323", "email": "test@razorpay.com"},
    };

    try {
      razorpay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment success");

    await addtoFirebase(null, response);
  }

  Future<void> addtoFirebase(amount, response) async {
    nextPage(
        context: context,
        page: const LoadingPage(
          text: 'Payment Processing',
        ));
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
        .collection('users')
        .doc(widget.doc['uid'])
        .collection('appointments')
        .where(
          'date',
          isEqualTo: widget._selectedValue.millisecondsSinceEpoch,
        )
        .where('hospital', isEqualTo: hospitalvalue)
        .orderBy("token", descending: true)
        .limit(1)
        .get();
    print("${result.docs}+++++++++++/////////////");
    print("+++++++++${widget.doc['uid']}");

    Appointment appointmentModel = Appointment();

    User? user = FirebaseAuth.instance.currentUser;

    appointmentModel.hospital = hospitalvalue;

    appointmentModel.date = widget._selectedValue.millisecondsSinceEpoch;
    appointmentModel.token =
        result.docs.isEmpty ? 1 : result.docs[0]['token'] + 1;
    appointmentModel.timing = widget.timing;
    appointmentModel.uid = widget.doc['uid'];
    appointmentModel.reason = widget.reason;
    var docvalue;
    await firebaseFirestore
        .collection('pusers')
        .doc(user!.uid)
        .collection('appointments')
        .add(appointmentModel.toMap())
        .then((value) => docvalue = value.id);
    appointmentModel.uid = user.uid;

    await firebaseFirestore
        .collection('users')
        .doc(widget.doc['uid'])
        .collection('appointments')
        .doc(docvalue)
        .set(appointmentModel.toMap());
    if (widget.wallet) {
      if (widget.wmoney >= num.parse(widget.appfee)) {
        await FirebaseFirestore.instance
            .collection('pusers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'Wallet': widget.wmoney - num.parse(widget.appfee)});
      } else if (widget.wmoney < num.parse(widget.appfee)) {
        await FirebaseFirestore.instance
            .collection('pusers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'Wallet': num.parse(widget.appfee) - widget.wmoney});
      }
    }
    NotificationService.sendNotification(
        title:
            'Appointment @$hospitalvalue on ${DateFormat('dd MMM yyyy ,EEE').format(widget._selectedValue)}',
        description: 'Dr.${widget.doc['name']}!!! You have an Appointment',
        token: widget.doc['token']);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.doc['uid'])
        .collection('notifications')
        .add({
      'title':
          'Appointment @$hospitalvalue on ${DateFormat('dd MMM yyyy ,EEE').format(widget._selectedValue)}',
      'description': 'Dr.${widget.doc['name']}!!! You have an Appointment',
      'read': false
    });
    nextPage(
        context: context,
        page: SucceessSrcreen(
          payment: response,
          fee: widget.appfee,
          date: DateFormat('dd MMM yyyy ,EEE').format(widget._selectedValue),
          token: appointmentModel.token!,
          timing: widget.timing,
          data: widget.doc,
          hospitalvalue: hospitalvalue,
        ));
  }

  void handlerErrorFailure(PaymentFailureResponse failureResponse) {
    print("Payment error");
    SnackBar(
        content: AwesomeSnackbarContent(
      contentType: ContentType.failure,
      message: "Payment Failed",
      title: failureResponse.message!,
    ));
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: () {
              num.parse(state.amount) <= 0
                  ? addtoFirebase(state.amount, null)
                  : openCheckout(state.amount);

              // nextPage(context: context, page: BookAppointmentWidget());
            },
            child: num.parse(state.amount) <= 0
                ? const Text('Pay')
                : Text('Pay ₹ ${state.amount}'));
      },
    );
  }
}
