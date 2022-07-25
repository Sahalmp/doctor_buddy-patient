import 'package:doctorbuddy/domain/colors.dart';
import 'package:flutter/material.dart';

import '../../../domain/constants.dart';
import '../HomeScreen/home_screen.dart';

class MyConsultsScreen extends StatelessWidget {
  const MyConsultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: primary,
                              ),
                              label: const Text(
                                'Kochi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: primary),
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications,
                                color: primary,
                              ))
                        ],
                      ),
                    ),
                  )),
                  const TabBar(
                    indicatorWeight: 4,
                    tabs: [
                      Text(
                        "Doctors",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "Hospitals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  const Divider(
                    height: 1,
                    thickness: 2,
                  )
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: background,
          child: TabBarView(
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: devSize.width * 0.02),
                  child: Center(
                    child: Text('No Records'),
                  )
                  // ListView(
                  //   children: const <Widget>[
                  //     DoctorListTile(
                  //       drname: 'Dr. Alexandra',
                  //       drimgurl: 'doctorfemale',
                  //       category: 'Eye Specialist',
                  //     ),
                  //     DoctorListTile(
                  //       drname: 'Dr. Sebastian',
                  //       drimgurl: 'doctormale',
                  //       category: 'Cardiologist',
                  //     ),
                  //   ],
                  ),
              Center(
                child: Text('No Records'),
              ),
              // ListView(
              //   children: const <Widget>[
              //     gheight_10,
              //     HospitalListTile(
              //       hsptlname: 'Columbia Asia Multispeciality',
              //     ),
              //     Divider(),
              //     gheight_10,
              //     HospitalListTile(
              //       hsptlname: 'Mother Hood International',
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
