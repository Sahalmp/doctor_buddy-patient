import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../../../../domain/colors.dart';

class StatusAppointmentWidget extends StatelessWidget {
  StatusAppointmentWidget({Key? key, required this.data, required this.appdata})
      : super(key: key);
  final DocumentSnapshot data;
  final DocumentSnapshot appdata;
  final List<String> months = [
    'January',
    'Febraury',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int? idx;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i <= data['hospital'].length; i++) {
      if (appdata['hospital'] == data['hospital'][i]['name']) {
        idx = i;
        break;
      }
    }
    final date = DateTime.fromMillisecondsSinceEpoch(appdata['date']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: primary,
        title: Text("${date.day} ${months[date.month - 1]} "),
      ),
      backgroundColor: background,
      body: ListView(
        children: [
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
                            value: appdata['hospital'],
                          ),
                          AppointmentStatusTimeWidget(
                            type: 'Timing:',
                            value: appdata['timing'],
                          )
                        ],
                      ),
                    ),
                  ),

                  gheight_10,
                  // const Divider(
                  //   thickness: 2,
                  // ),

                  const Text(
                    'Current Appointment status',
                    style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  gheight_20,
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(data['uid'])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final sdata = snapshot.data!['hospital'][idx]['status'];
                        print("$sdata========");
                        return !sdata
                            ? const Text('Doctor Unavailable')
                            : AvatarGlow(
                                glowColor: primary,
                                duration: const Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                endRadius: 90,
                                child: Material(
                                  elevation: 20.0,
                                  shape: const CircleBorder(),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: primary,
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(data['uid'])
                                            .collection('appointments')
                                            .orderBy("token")
                                            .limit(1)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          return Text(
                                            snapshot.data!.docs.isEmpty
                                                ? "0"
                                                : snapshot
                                                    .data!.docs[0]['token']
                                                    .toString(),
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 50),
                                          );
                                        }),
                                  ),
                                ),
                              );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Your Token no is ',
                          style: TextStyle(
                              color: primary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          backgroundColor: primary,
                          child: Text(
                            '${appdata['token']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentStatusTimeWidget extends StatelessWidget {
  const AppointmentStatusTimeWidget(
      {Key? key, required this.type, required this.value})
      : super(key: key);
  final String type;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type),
        Text(
          value,
          style: TextStyle(color: primary, fontSize: 16),
        ),
      ],
    );
  }
}
