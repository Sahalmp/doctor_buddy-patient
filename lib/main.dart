import 'package:doctorbuddy/presentation/Screens/HomeScreen/home_screen.dart';
import 'package:doctorbuddy/presentation/Screens/Mainscreen/mainscreen.dart';
import 'package:doctorbuddy/presentation/Screens/registration/adddetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'application/Home/home_bloc.dart';
import 'application/datafetch/data_bloc.dart';
import 'application/details/details_bloc.dart';
import 'domain/colors.dart';
import 'domain/di/di.dart';
import 'presentation/Screens/Login/loginscreen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await Firebase.initializeApp();

  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cauth = FirebaseAuth.instance.currentUser;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primary,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => getIt<HomeBloc>()),
          BlocProvider(create: (ctx) => getIt<DetailsBloc>()),
          BlocProvider(create: (ctx) => getIt<DataBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              tabBarTheme: const TabBarTheme(
                  labelColor: primary, unselectedLabelColor: Colors.grey),
              fontFamily: GoogleFonts.outfit().fontFamily,
              primaryColor: primary,
              primarySwatch: Colors.indigo,
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(primary))),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primary),
              ))),
          home: cauth == null ? LoginScreen() : MainScreen(),
        ));
  }
}
