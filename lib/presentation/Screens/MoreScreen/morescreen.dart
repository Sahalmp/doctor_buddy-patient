import 'package:about/about.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/Appointments/appointments.dart';
import 'package:doctorbuddy/presentation/Screens/MoreScreen/editprofilescreen.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/nextpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../application/datafetch/data_bloc.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DataBloc>(context).add(Getdata());

    return ListView(
      children: <Widget>[
        Container(
          color: primary,
          child: Column(
            children: [
              BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.wallet,
                          color: whiteColor,
                        ),
                        Text(
                          ' Wallet: ₹  ${state.userModel!.wallet}',
                          style: const TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                  );
                },
              ),
              gheight_40,
              gheight_30,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('asset/images/doctorlogo2.png'),
                    width: 70,
                  ),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'G',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                      TextSpan(
                          text: 'et',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                      TextSpan(
                          text: 'M',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                      TextSpan(
                          text: 'y',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                      TextSpan(
                          text: 'D',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                      TextSpan(
                          text: 'oc',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: whiteColor),
                          )),
                    ]),
                  ),
                ],
              ),
              gheight_50,
              const Divider(
                height: 2,
                thickness: 5,
                color: whiteColor,
              )
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            leading: const Icon(
              Icons.person_pin,
              color: primary,
              size: 40,
            ),
            title: const Text('Edit Profile'),
            subtitle: const Text('View and modify profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              nextPage(context: context, page: EditProfileScreen());
            },
          ),
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            leading: const Icon(
              Icons.edit_calendar,
              color: primary,
              size: 40,
            ),
            title: const Text('Appoinments'),
            subtitle: const Text('View appointments'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              nextPage(context: context, page: Appointments());
            },
          ),
        ),
        gheight_10,
        const Divider(
          thickness: 2,
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: primary,
              size: 40,
            ),
            title: const Text('Logout'),
            subtitle: const Text('LogOut of this  device'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              FirebaseAuth.instance.signOut().then(((value) {
                pushRemove(context: context, page: LoginScreen());
              }));
            },
          ),
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            onTap: () {
              showAboutPage(
                context: context,
                values: {
                  'version': '1.0',
                  'year': DateTime.now().year.toString(),
                },
                applicationLegalese: 'Copyright © BrotoType, {{ year }}',
                applicationDescription: const Text(
                    'An Application for Booking appointment for doctors.'),
                children: const <Widget>[
                  MarkdownPageListTile(
                    icon: Icon(Icons.list),
                    title: Text('Changelog'),
                    filename: 'CHANGELOG.md',
                  ),
                  LicensesPageListTile(
                    icon: Icon(Icons.favorite),
                  ),
                ],
                applicationIcon: const SizedBox(
                  width: 100,
                  child: Image(
                    image: AssetImage('asset/images/splash.png'),
                  ),
                ),
              );
            },
            leading: const Icon(
              Icons.info_outline,
              color: primary,
              size: 40,
            ),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        const Divider(thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            child: const Text(
              'Are you a doctor',
              style: TextStyle(decoration: TextDecoration.underline),
              textAlign: TextAlign.end,
            ),
            onTap: () {
              // if (!await launchUrl(Uri.parse('url'))) {
              //   throw 'Could not launch';
              // }
            },
          ),
        ),
      ],
    );
  }
}
