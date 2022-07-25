import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:flutter/material.dart';

import '../../Login/verificationscreen.dart';
import '../home_screen.dart';

class ViewAllDoctors extends StatelessWidget {
  const ViewAllDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Doctors",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        foregroundColor: primary,
        backgroundColor: background,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [
                  gheight_10,
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];

                          return DoctorListTile(
                            index: index,
                            drname: doc['name'],
                            drimgurl: doc['image'],
                            category: 'Cardiologist',
                          );
                        },
                        separatorBuilder: (context, index) {
                          return gheight_10;
                        },
                      )),
                ],
              );
            }
          }),
    );
  }
}
