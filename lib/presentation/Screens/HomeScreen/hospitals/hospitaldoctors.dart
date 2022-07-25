import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class ViewHospitalDoctors extends StatelessWidget {
  const ViewHospitalDoctors({Key? key, required this.hospitalname})
      : super(key: key);
  final String hospitalname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalname),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  List hospitals = ds['hospital'];
                  for (int i = 0; i < hospitals.length; i++) {
                    if (hospitalname == ds['hospital'][i]['name']) {
                      return DoctorListTile(
                          index: index,
                          drname: ds['name'],
                          drimgurl: ds['image'],
                          category: ds['category']);
                    } else {
                      return SizedBox();
                    }
                  }
                  return SizedBox();
                });
          }),
    );
  }
}
