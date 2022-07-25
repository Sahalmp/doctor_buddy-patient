import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/chat.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    String? type;

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
                    backgroundImage: NetworkImage(widget.doc['image']),
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
                          "Dr. ${widget.doc['name']}".toTitleCase(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.doc['category'],
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
                  .collection('chats')
                  .orderBy('timestamp', descending: false)
                  .where('doctor', isEqualTo: widget.doc['uid'])
                  .where('patient',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, QueryDocumentSnapshot snapshot) {
                      DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
                          snapshot['timestamp']);
                      final time = TimeOfDay.fromDateTime(datetime);
                      if (snapshot['type'] == 'patient') {
                        type = "sender";
                      } else {
                        type = "receiver";
                      }
                      return GestureDetector(
                        onLongPress: () {
                          _delete(context, snapshot);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (type == "receiver"
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (type == "receiver"
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    snapshot['content'],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Text(
                                  "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}",
                                  style: const TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        User? user = FirebaseAuth.instance.currentUser;
                        ChatMessages chatMessages = ChatMessages(
                            type: 'patient',
                            patient: auth.currentUser!.uid,
                            doctor: widget.doc['uid'],
                            timestamp: DateTime.now().millisecondsSinceEpoch,
                            content: controller.text);
                        controller.clear();

                        await firebaseFirestore
                            .collection('chats')
                            .add(chatMessages.toMap());
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
                        .collection('chats')
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

