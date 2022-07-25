import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/status.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  Appointments({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    User? user = _auth.currentUser;
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Appointments",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          foregroundColor: primary,
          backgroundColor: background,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.03),
          child: ListView(
            children: [
              gheight_10,
              StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore
                      .collection('pusers')
                      .doc(user!.uid)
                      .collection('appointments')
                      .orderBy('date')
                      .snapshots(),
                  builder: (context, appointmentsnapshot) {
                    if (!appointmentsnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: appointmentsnapshot.data!.docs.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot appdata =
                              appointmentsnapshot.data!.docs[index];

                          return StreamBuilder<QuerySnapshot>(
                              stream: firebaseFirestore
                                  .collection('users')
                                  .where('uid', isEqualTo: appdata['uid'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                DocumentSnapshot data = snapshot.data!.docs[0];
                                final date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        appdata['date']);
                                final todaysdate = DateTime.now();

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                      onLongPress: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)), //this right here

                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      child: const Text('No')),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'pusers')
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .collection(
                                                                'appointments')
                                                            .doc(appdata.id)
                                                            .delete();
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(data['uid'])
                                                            .collection(
                                                                'appointments')
                                                            .doc(appdata.id)
                                                            .delete();
                                                      },
                                                      child: const Text('Yes'))
                                                ],
                                                title: const Text(
                                                    'Do you want to confirm delete'),
                                              );
                                            });
                                      },
                                      onTap: () => nextPage(
                                          context: context,
                                          page: StatusAppointmentWidget(
                                            data: data,
                                            appdata: appdata,
                                          )),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      tileColor: whiteColor,
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data['image']),
                                      ),
                                      title: Text(
                                        data['name'],
                                      ),
                                      subtitle: Text(
                                          "${data['category']}\n ${appdata['hospital']}"),
                                      trailing: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                              child: Text(
                                                date.day == todaysdate.day
                                                    ? "Today"
                                                    : "${date.day.toString().padLeft(2, "0")} ${months[date.month - 1]}",
                                                style: const TextStyle(
                                                    color: whiteColor),
                                              ),
                                            ),
                                          ),
                                          gwidth_10,
                                          CircleAvatar(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: CircleAvatar(
                                                backgroundColor: background,
                                                child: Text(
                                                  appdata['token'].toString(),
                                                  style: TextStyle(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              });
                        });
                  }),
            ],
          ),
        ));
  }
}
