import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/colors.dart';

class CategoryDoctorsWidget extends StatelessWidget {
  const CategoryDoctorsWidget({Key? key, required this.categoryname})
      : super(key: key);
  final String categoryname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            categoryname,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          foregroundColor: primary,
          backgroundColor: background,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('users')
                .where("category", isEqualTo: categoryname)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No doctor Found'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: whiteColor,
                          title: Text(
                            doc['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: primary),
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: background,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(doc['image'])),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_sharp),
                          onTap: () {
                            // nextPage(context: context, page: const DoctorDetails(index: index,));
                          },
                        );
                      }),
                );
              }
            }));
  }
}
