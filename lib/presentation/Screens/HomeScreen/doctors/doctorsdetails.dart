import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/chat.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/prescriptions.dart';
import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/colors.dart';
import '../../../widgets/navigation/nextpage.dart';

class DoctorDetails extends StatelessWidget {
  DoctorDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    DocumentSnapshot? doc;
    return Scaffold(
      backgroundColor: background,
      body: ListView(children: <Widget>[
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
              IconButton(
                  onPressed: () {
                    nextPage(
                        context: context,
                        page: ChatScreen(
                          doc: doc!,
                        ));
                  },
                  icon: const Icon(Icons.chat)),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              doc = snapshot.data!.docs[index];

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
                        backgroundImage: NetworkImage(doc!['image']),
                      ),
                    ),
                  ),
                  gheight_10,
                  Text(
                    "Dr. ${doc!['name']}".toTitleCase(),
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                  ),
                  Text(
                    doc!['category'],
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    doc!['qualification'],
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  Text(
                    doc!['place'],
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  // const Text(
                  //   '12+ Years Experience',
                  //   style: TextStyle(color: Colors.blueGrey),
                  // ),
                  gheight_30,
                  const Text(
                    "Appointment Fee: ₹350",
                    style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              );
            }),
        const Divider(
          thickness: 3,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Prescriptions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              gheight_20,
              InkWell(
                onTap: () {
                  nextPage(context: context, page: const PrescriptionScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: whiteColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          color: primary,
                        ),
                        height: 50,
                        width: 80,
                        child: const Center(
                          child: Text(
                            '15 March\n2021',
                            style: TextStyle(color: whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      gwidth_10,
                      const Text(
                        'Cataract',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
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
              ),
              const SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ElevatedButton(
                      onPressed: () {
                        nextPage(
                            context: context,
                            page: BookAppointmentWidget(index: index));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text('Book Appointment'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
