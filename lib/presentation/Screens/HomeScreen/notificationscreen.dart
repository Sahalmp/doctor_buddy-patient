import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/colors.dart';

class ScreenNotification extends StatelessWidget {
  const ScreenNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('pusers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('notifications')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No notifications'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data!.docs[index]['read'] == false) {
                    FirebaseFirestore.instance
                        .collection('pusers')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('notifications')
                        .doc(snapshot.data!.docs[index].id)
                        .update({'read': true});
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4.0),
                    child: Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        FirebaseFirestore.instance
                            .collection('pusers')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('notifications')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                      child: ListTile(
                        tileColor: whiteColor,
                        leading: const Icon(
                          Icons.notifications,
                          size: 30,
                          color: primary,
                        ),
                        subtitle:
                            Text(snapshot.data!.docs[index]['description']),
                        title: Text(snapshot.data!.docs[index]['title']),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
