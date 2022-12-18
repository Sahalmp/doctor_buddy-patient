import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/chat.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? type;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(data['image']),
                          maxRadius: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Dr. ${data['name']}".toTitleCase(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                data['category'],
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Stack(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .collection('chatTo')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('messages')
                        .orderBy('timestamp', descending: false)
                        .where('doctor', isEqualTo: data['uid'])
                        .where('patient',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                      // if (snapshot.hasError) {
                      //   return Center(child: Text('error'));
                      // }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: Text('loading'));
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: GroupedListView<QueryDocumentSnapshot, DateTime>(
                          elements: snapshot.data!.docs,
                          reverse: true,
                          order: GroupedListOrder.DESC,
                          floatingHeader: true,
                          useStickyGroupSeparators: true,
                          groupBy: (QueryDocumentSnapshot element) {
                            // print(element['timestamp']);

                            return DateTime(
                                DateTime.fromMillisecondsSinceEpoch(
                                        element['timestamp'])
                                    .year,
                                DateTime.fromMillisecondsSinceEpoch(
                                        element['timestamp'])
                                    .month,
                                DateTime.fromMillisecondsSinceEpoch(
                                        element['timestamp'])
                                    .day);
                          },
                          groupHeaderBuilder: _createGroupHeader,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder:
                              (context, QueryDocumentSnapshot snapshot) {
                            DateTime datetime =
                                DateTime.fromMillisecondsSinceEpoch(
                                    snapshot['timestamp']);
                            final time = TimeOfDay.fromDateTime(datetime);
                            if (snapshot['type'] == 'patient') {
                              type = "sender";
                            } else {
                              type = "receiver";
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.uid)
                                  .collection('chatTo')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('messages')
                                  .doc(snapshot.id)
                                  .update({'read': true});
                            }
                            return GestureDetector(
                              onLongPress: type == "sender"
                                  ? () {
                                      _delete(context, snapshot);
                                    }
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, top: 5, bottom: 5),
                                child: Column(
                                  crossAxisAlignment: type == "receiver"
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: (type == "receiver"
                                            ? Colors.grey.shade200
                                            : Colors.blue[200]),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot['content'],
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13.0, left: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${time.hourOfPeriod}:${time.minute.toString().padLeft(2, '0')} ${time.period.name.toUpperCase()}",
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    type != "receiver"
                                                        ? Icon(
                                                            snapshot['read']
                                                                ? Icons.done_all
                                                                : Icons.done,
                                                            size: 13,
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              if (controller.text.isNotEmpty &&
                                  controller.text.trim() != "") {
                                FirebaseFirestore firebaseFirestore =
                                    FirebaseFirestore.instance;
                                User? user = FirebaseAuth.instance.currentUser;
                                ChatMessages chatMessages = ChatMessages(
                                    read: false,
                                    type: 'patient',
                                    patient: auth.currentUser!.uid,
                                    doctor: data['uid'],
                                    timestamp:
                                        DateTime.now().millisecondsSinceEpoch,
                                    content: controller.text);
                                controller.clear();
                                await firebaseFirestore
                                    .collection('users')
                                    .doc(widget.uid)
                                    .collection('chatTo')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({
                                  'chatuid':
                                      FirebaseAuth.instance.currentUser!.uid
                                });
                                final DocumentReference<Map<String, dynamic>>
                                    ds = await firebaseFirestore
                                        .collection('users')
                                        .doc(widget.uid)
                                        .collection('chatTo')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('messages')
                                        .add(chatMessages.toMap());
                              }
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: primary,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _delete(BuildContext context, ds) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Delete Messege?'),
            content: const Text('Are you sure to delete this message?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    // Remove the box
                    Navigator.of(context).pop();

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .collection('chatTo')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('messages')
                        .doc(ds.id)
                        .delete();

                    // Close the dialog
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  Widget _createGroupHeader(QueryDocumentSnapshot element) {
    // print(element['timestamp']);
    DateTime now = DateTime.now();
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(element['timestamp']);
    String formatedDate = now.day == dateTime.day &&
            now.month == dateTime.month &&
            now.year == dateTime.year
        ? "Today"
        : DateFormat("MMM dd").format(dateTime);
    return SizedBox(
      height: 40,
      child: Align(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              formatedDate,
              style: TextStyle(color: primary),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
