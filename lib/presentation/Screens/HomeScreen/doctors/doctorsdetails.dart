import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/main.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/chat.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/prescriptions.dart';

import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../domain/colors.dart';
import '../../../widgets/navigation/nextpage.dart';

class DoctorDetails extends StatelessWidget {
  DoctorDetails({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: background,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              gheight_10,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('chatTo')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('messages')
                                .where('doctor', isEqualTo: uid)
                                .where('patient',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where('read', isEqualTo: false)
                                .where('type', isEqualTo: 'doctor')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: SizedBox());
                              }

                              return Visibility(
                                visible: snapshot.data!.docs.length == 0
                                    ? false
                                    : true,
                                child: Positioned(
                                  top: 0,
                                  right: 2,
                                  child: CircleAvatar(
                                    backgroundColor: primary,
                                    radius: 10,
                                    child: Text(
                                        snapshot.data!.docs.length.toString()),
                                  ),
                                ),
                              );
                            }),
                        IconButton(
                            onPressed: () {
                              nextPage(
                                  context: context,
                                  page: ChatScreen(
                                    uid: uid,
                                  ));
                            },
                            icon: const Icon(Icons.chat)),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: firestore.collection('users').doc(uid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final data = snapshot.data!;

                    return Column(
                      children: [
                        gheight_20,
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white38,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(data['image']),
                            ),
                          ),
                        ),
                        gheight_10,
                        Text(
                          "Dr. ${data['name']}".toTitleCase(),
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22)),
                        ),
                        Text(
                          data['category'],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Text(
                          data['qualification'],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Text(
                          data['place'],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        // const Text(
                        //   '12+ Years Experience',
                        //   style: TextStyle(color: Colors.blueGrey),
                        // ),
                        gheight_30,
                      ],
                    );
                  }),
              const Divider(
                thickness: 3,
              ),
              Expanded(
                child: ListView(children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prescriptions',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        gheight_20,
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('prescription')
                                .where('patientid',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .where('doctorid', isEqualTo: uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot<Object?>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text('No Records'),
                                );
                              }
                              return ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          gheight_10,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot prescrdata =
                                        snapshot.data!.docs[index];
                                    DateTime date =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            prescrdata['date']);
                                    DateFormat df =
                                        DateFormat('dd MMMM\n yyyy');

                                    String formatteddate = df.format(date);
                                    // pdata = prescrdata;
                                    return InkWell(
                                      onTap: () {
                                        nextPage(
                                            context: context,
                                            page: PrescriptionScreen(
                                              prescrdata: prescrdata['pdata'],
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: whiteColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8)),
                                                color: primary,
                                              ),
                                              height: 50,
                                              width: 80,
                                              child: Center(
                                                child: Text(
                                                  formatteddate,
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            gwidth_10,
                                            Text(
                                              prescrdata['reason'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.grey,
                                            ),
                                            gwidth_10,
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ElevatedButton(
                        onPressed: () {
                          nextPage(
                              context: context,
                              page: BookAppointmentWidget(uid: uid));
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Book Appointment'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
