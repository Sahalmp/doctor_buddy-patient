import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../domain/colors.dart';

class ViewallHospitals extends StatelessWidget {
  const ViewallHospitals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Hospitals",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        foregroundColor: primary,
        backgroundColor: background,
      ),
      body: Column(
        children: [
          gheight_10,
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hospitals')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      DocumentSnapshot ds = snapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2),
                        child: HospitalListTile(
                          hsptlname: "${ds['name']}",
                        ),
                      );
                    });
              }),
        ],
      ),
    );
  }
}
