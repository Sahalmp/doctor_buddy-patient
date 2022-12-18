import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/user/usermodel.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CustomSearchDelegate extends SearchDelegate {
  late List<String> searchTerms = [];

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(""""$query" not found in list"""),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List doctors = [];

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            doctors.add(DoctorModel(
                uid: snapshot.data!.docs[i]['uid'],
                category: snapshot.data!.docs[i]['category'],
                name: snapshot.data!.docs[i]['name'],
                image: snapshot.data!.docs[i]['image']));
          }

          final listItems = query.isEmpty
              ? doctors
              : doctors
                  .where((element) => element.name
                      .toLowerCase()
                      .contains(query.toLowerCase().toString()))
                  .toList();
          return ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                print(doctors[index].name.toString());
                print(query);
                return DoctorListTile(
                    uid: listItems[index].uid,
                    drname: listItems[index].name,
                    drimgurl: listItems[index].image,
                    category: listItems[index].category);
              });
        });
  }
}
