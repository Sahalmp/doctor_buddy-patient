import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/categories/categorydoctors.dart/categorydoctors.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/categories/viewallcategories.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/doctorsdetails.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/doctors/viewalldoctors.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/hospitals/hospitaldoctors.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/hospitals/viewallhospitals.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/location/locationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/notificationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/HomeScreen/search.dart';
import 'package:doctorbuddy/presentation/Screens/Login/verificationscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/bookappointments.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../application/datafetch/data_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    BlocProvider.of<DataBloc>(context).add(Getdata());

    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(300))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              nextPage(
                                  context: context, page: LocationScreen());
                            },
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: whiteColor,
                            ),
                            label: Text(
                              "${state.userModel?.place}",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: whiteColor),
                            )),
                        IconButton(
                            onPressed: () {
                              nextPage(
                                  context: context, page: ScreenNotification());
                            },
                            icon: const Icon(
                              Icons.notifications,
                              color: whiteColor,
                            ))
                      ],
                    ),
                    gheight_20,
                    Text(
                      'Hello, ${state.userModel?.name!.split(" ").first ?? ""}',
                      style: GoogleFonts.poppins(
                        textStyle:
                            const TextStyle(fontSize: 20, color: whiteColor),
                      ),
                    ),
                    gheight_20,
                    const Align(
                      child: Text(
                        'Find your doctor now',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    gheight_20,
                    SizedBox(
                      height: 35,
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            hintText: 'Search Doctors, hospitals',
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30))),
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate());
                        },
                      ),
                    ),
                    gheight_20,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.08),
              child: Column(
                children: [
                  gheight_10,
                  const BrowseRowWidget(
                    type: 'Browse by Category',
                  ),
                  gheight_10,
                  StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection('category').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              children: List.generate(
                                  snapshot.data!.docs.length.clamp(1, 3),
                                  (index) {
                                DocumentSnapshot ds =
                                    snapshot.data!.docs[index];

                                return GridChildContainer(
                                  categoryname: ds['name'],
                                  imgiconurl: "${ds['image']}",
                                );
                              }));
                        }
                      }),
                  gheight_20,
                  const BrowseRowWidget(
                    type: 'Near by Doctors',
                  ),
                  gheight_10,
                  StreamBuilder<QuerySnapshot>(
                      stream: firestore
                          .collection('users')
                          .where('place', isEqualTo: state.userModel!.place)
                          .where('hospital')
                          .where('hospital', isNotEqualTo: []).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text('No Doctors'),
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length.clamp(0, 2),
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];

                                return Column(
                                  children: [
                                    DoctorListTile(
                                      uid: doc['uid'],
                                      drname:
                                          "Dr. ${doc['name']}".toTitleCase(),
                                      drimgurl: doc['image'],
                                      category: doc['category'],
                                    ),
                                    gheight_10,
                                  ],
                                );
                              });
                        }
                      }),
                  gheight_20,
                  const BrowseRowWidget(
                    type: 'Near by Hospitals',
                  ),
                  gheight_10,
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('hospitals')
                          .where('place', isEqualTo: state.userModel?.place)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No Hospitals'),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length.clamp(0, 2),
                            itemBuilder: (context, index) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              DocumentSnapshot ds = snapshot.data!.docs[index];

                              return HospitalListTile(
                                hsptlname: "${ds['name']}",
                              );
                            });
                      }),
                  gheight_30,
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class HospitalListTile extends StatelessWidget {
  final String hsptlname;
  const HospitalListTile({Key? key, required this.hsptlname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: whiteColor,
        leading: const CircleAvatar(
            backgroundColor: whiteColor,
            child: Image(
              image: AssetImage(
                'asset/images/hospital.png',
              ),
              width: 30,
            )),
        title: Text(hsptlname,
            style:
                const TextStyle(fontWeight: FontWeight.w500, color: primary)),
        trailing: const Icon(Icons.arrow_forward_ios_sharp),
        onTap: () {
          nextPage(
              context: context,
              page: ViewHospitalDoctors(
                hospitalname: hsptlname,
              ));
        },
      ),
    );
  }
}

class DoctorListTile extends StatelessWidget {
  final String drname;
  final String? drimgurl;
  final String category;
  final String uid;
  const DoctorListTile(
      {Key? key,
      required this.uid,
      required this.drname,
      required this.drimgurl,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      subtitle: Text(category),
      tileColor: whiteColor,
      minVerticalPadding: 0,
      title: Text(
        drname,
        style: const TextStyle(fontWeight: FontWeight.bold, color: primary),
        overflow: TextOverflow.ellipsis,
      ),
      leading: drimgurl == null
          ? const CircleAvatar(
              child: Icon(Icons.person),
            )
          : CircleAvatar(
              radius: 30,
              backgroundColor: background,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(drimgurl!)),
              ),
            ),
      trailing: const Icon(Icons.arrow_forward_ios_sharp),
      onTap: () {
        nextPage(context: context, page: DoctorDetails(uid: uid));
      },
    );
  }
}

class BrowseRowWidget extends StatelessWidget {
  final String type;
  const BrowseRowWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextPage(
            context: context,
            page: type == 'Browse by Category'
                ? ViewAllCategories()
                : type == 'Near by Doctors'
                    ? ViewAllDoctors()
                    : ViewallHospitals());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(' $type',
              style: const TextStyle(
                  color: primary, fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: const [
              Text('Viewall',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 110, 112))),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GridChildContainer extends StatelessWidget {
  final String imgiconurl;
  final String categoryname;
  GridChildContainer(
      {Key? key, required this.imgiconurl, required this.categoryname})
      : super(key: key);
  String iconurl = "asset/images/doctor.png";
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextPage(
            context: context,
            page: CategoryDoctorsWidget(
              categoryname: categoryname,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: imgiconurl.isEmpty
                  ? AssetImage(imgiconurl)
                  : AssetImage(iconurl),
              height: 30,
            ),
            Text(categoryname)
          ],
        ),
      ),
    );
  }
}
