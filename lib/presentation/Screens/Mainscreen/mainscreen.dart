import 'package:doctorbuddy/application/datafetch/data_bloc.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/di/di.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/morescreen.dart';
import 'package:doctorbuddy/presentation/Screens/MyConsults/myconsults.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/Home/home_bloc.dart';
import '../HomeScreen/home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Widget> pages = <Widget>[
    const MyConsultsScreen(),
    HomeScreen(),
    const MoreScreen()
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DataBloc>(context).add(const DataEvent.getdata());
      BlocProvider.of<HomeBloc>(context)
          .add(const Getbottomnavbarpage(index: 1));
    });
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: Scaffold(
              backgroundColor: background,
              body: pages[state.index],
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: BottomNavigationBar(
                    enableFeedback: true,
                    elevation: 8,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.note_add_outlined),
                          label: 'My Consults'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.menu), label: 'More')
                    ],
                    selectedItemColor: primary,
                    currentIndex: state.index,
                    onTap: (value) {
                      BlocProvider.of<HomeBloc>(context)
                          .add(Getbottomnavbarpage(index: value));
                    },
                  ),
                ),
              )),
        );
      },
    );
  }
}
