import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/constants.dart';
import '../../widgets/navigation/nextpage.dart';
import '../HomeScreen/doctors/doctorsdetails.dart';
import '../HomeScreen/home_screen.dart';

class MyConsultsScreen extends StatelessWidget {
  const MyConsultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: const Text('My Consults'),
      ),
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: primary,
                  height: 2,
                  width: devSize.width * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Recent Consults',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: primary,
                    height: 2,
                  ),
                ),
              ],
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('prescription')
                        .where('patientid', isEqualTo: auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("No records"),
                        );
                      }
                      var temp = "";

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data!.docs.length);
                            DocumentSnapshot ds = snapshot.data!.docs[index];

                            return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where(
                                      'uid',
                                      isEqualTo: ds['doctorid'],
                                    )
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: Text('No records'),
                                    );
                                  }
                                  if (temp == snapshot.data!.docs[0]['uid']) {
                                    return SizedBox();
                                  } else {
                                    temp = snapshot.data!.docs[0]['uid'];
                                    return ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      subtitle: Text(
                                          snapshot.data!.docs[0]['category']),
                                      tileColor: whiteColor,
                                      minVerticalPadding: 0,
                                      title: Text(
                                        snapshot.data!.docs[0]['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primary),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: background,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data!.docs[0]
                                                      ['image'])),
                                        ),
                                      ),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_sharp),
                                      onTap: () {
                                        nextPage(
                                            context: context,
                                            page: DoctorDetails(
                                                uid: snapshot.data!.docs[0]
                                                    ['uid']));
                                      },
                                    );
                                  }
                                });
                          },
                          separatorBuilder: (context, index) => gheight_10,
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

String getdate(dateInt) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInt);
  DateFormat df = DateFormat('dd MMMM\n yyyy');

  String formatteddate = df.format(date);
  return formatteddate;
}
