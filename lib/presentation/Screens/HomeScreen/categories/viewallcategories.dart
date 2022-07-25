import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:flutter/material.dart';

import '../../Login/verificationscreen.dart';
import '../home_screen.dart';

class ViewAllCategories extends StatelessWidget {
  const ViewAllCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        foregroundColor: primary,
        backgroundColor: background,
      ),
      body: ListView(
        children: [
          gheight_10,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('category').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        children:
                            List.generate(snapshot.data!.docs.length, (index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];

                          return GridChildContainer(
                            categoryname: ds['name'],
                            imgiconurl: "${ds['image']}",
                          );
                        }));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
