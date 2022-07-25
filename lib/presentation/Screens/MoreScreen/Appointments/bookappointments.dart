import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctorbuddy/domain/appointment/appointment.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../application/details/details_bloc.dart';
import '../../../widgets/navigation/nextpage.dart';

String hospitalvalue = '';

class BookAppointmentWidget extends StatelessWidget {
  BookAppointmentWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  final TextEditingController remarkcontroler = TextEditingController();
  DateTime _selectedValue =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String? timing;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailsBloc>(context).add(const Gethospital(hospital: ''));
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Book Appointment",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        foregroundColor: primary,
        backgroundColor: background,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            DocumentSnapshot doc = snapshot.data!.docs[index];
            return ListView(children: [
              gheight_30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: primary,
                    child: CircleAvatar(
                      backgroundColor: background,
                      radius: 33,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(doc['image']),
                      ),
                    ),
                  ),
                  gwidth_10,
                  Column(
                    children: [
                      Text(
                        "Dr. ${doc['name']}".toTitleCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary,
                            fontSize: 20),
                      ),
                      Text(doc['category'])
                    ],
                  )
                ],
              ),
              gheight_20,
              const Divider(
                thickness: 3,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(doc['uid'])
                      .collection('timing')
                      .snapshots(),
                  builder: (context, snapshot) {
                    print('${doc.id}========================');
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Available',
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    DocumentSnapshot ds =
                                        snapshot.data!.docs[index];
                                    timing = "${ds['start']} to ${ds['end']}";

                                    return BlocBuilder<DetailsBloc,
                                        DetailsState>(
                                      builder: (context, state) {
                                        return ListTile(
                                            leading: Radio<String>(
                                                value: ds['hospital'],
                                                groupValue: state.hospital,
                                                onChanged: (value) {
                                                  hospitalvalue =
                                                      value.toString();
                                                  context
                                                      .read<DetailsBloc>()
                                                      .add(Gethospital(
                                                          hospital: value));
                                                }),
                                            title: Row(children: [
                                              const Icon(
                                                  Icons.local_hospital_sharp),
                                              gwidth_10,
                                              Text(
                                                ds['hospital'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primary,
                                                    fontSize: 18),
                                              ),
                                            ]),
                                            subtitle: Text(
                                                "${ds['start']} to ${ds['end']}"));
                                      },
                                    );
                                  }),
                              gheight_10,
                              gheight_20,
                              const Text(
                                'Select Date',
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: DatePicker(DateTime.now(),
                                  width: 80,
                                  initialSelectedDate: DateTime.now(),
                                  selectionColor: Colors.black,
                                  daysCount: 7,
                                  inactiveDates: [],
                                  selectedTextColor: Colors.white,
                                  onDateChange: (date) {
                                // New date selected
                                _selectedValue = date;
                                print(_selectedValue.minute);
                              }),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Remarks',
                                style: TextStyle(color: primary),
                              ),
                              TextFormField(
                                controller: remarkcontroler,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 5,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ElevatedButton(
                      onPressed: () async {
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        QuerySnapshot<Map<String, dynamic>> result =
                            await firebaseFirestore
                                .collection('users')
                                .doc(doc['uid'])
                                .collection('appointments')
                                .where(
                                  'date',
                                  isEqualTo:
                                      _selectedValue.millisecondsSinceEpoch,
                                )
                                .where('hospital', isEqualTo: hospitalvalue)
                                .get();
                        print("+++++++++${doc['uid']}");
                        for (var element in result.docs) {
                          if (element['uid'] == auth.currentUser!.uid &&
                              element['date'] ==
                                  _selectedValue.millisecondsSinceEpoch &&
                              element['hospital'] == hospitalvalue &&
                              element['timing'] == timing) {
                            print("=============${doc['uid']}");
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                  SnackBar(content: Text('Already Booked')));
                            return;
                          }
                        }
                        await ConfirmBottomsheet(context, doc, timing, result,
                            firebaseFirestore, remarkcontroler.text.trim());
                        // nextPage(context: context, page: RazorpayScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text('Book now'),
                      ),
                    ),
                  )
                ],
              )
            ]);
          }),
    );
  }

  Future ConfirmBottomsheet(
      BuildContext context,
      DocumentSnapshot<Object?> doc,
      String? timing,
      QuerySnapshot<Map<String, dynamic>> result,
      FirebaseFirestore firebaseFirestore,
      String remark) async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // gheight_10,
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Lets Confirm Booking an Appointment ',
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        gheight_10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor: background,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(doc['image']),
                              ),
                            ),
                            gwidth_10,
                            Text(
                              "Dr. ${doc['name']}".toTitleCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.domain_add_outlined),
                          title: Text(
                            hospitalvalue,
                          ),
                          subtitle: Text("${doc['place']}".toCapitalized()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.timer_outlined),
                                  gwidth_10,
                                  Text('$timing')
                                ],
                              ),
                              Row(
                                children: [
                                  gwidth_30,
                                  Wrap(
                                    children: [
                                      Text(
                                          " Date: ${"${_selectedValue.day}".padLeft(2, '0')} ${months[_selectedValue.month]} ${_selectedValue.year}"),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Reason: $remark"),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Paymentwidget(
                              reason: remark,
                              timing: timing!,
                              selectedValue: _selectedValue,
                              doc: doc,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]));
        });
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
