import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../application/datafetch/data_bloc.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.subAdministrativeArea}';
    setState(() {});
  }

  String? countryValue = "";

  String? stateValue = "";

  String? cityValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text('Location'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadTextLocation(
            text: "Get location from below",
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton.icon(
                style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide?>(BorderSide())),
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();
                  GetAddressFromLatLong(position);
                },
                icon: const Icon(Icons.location_searching),
                label: Text(' $Address')),
          ),
          Divider(),
          const HeadTextLocation(text: "Select Location Manually"),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CSCPicker(
              defaultCountry: DefaultCountry.India,
              disableCountry: true,
              onCountryChanged: (value) {
                countryValue = value;
              },
              onStateChanged: (value) {
                stateValue = value;
              },
              onCityChanged: (value) {
                cityValue = value;
              },
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    if (Address != "search") {
                      FirebaseFirestore.instance
                          .collection('pusers')
                          .doc(auth.currentUser!.uid)
                          .update({'place': Address});
                    } else if (cityValue != "") {
                      FirebaseFirestore.instance
                          .collection('pusers')
                          .doc(auth.currentUser!.uid)
                          .update({
                        'place': cityValue!
                            .replaceAll(RegExp(r'ā'), 'a')
                            .replaceAll(RegExp(r'ū'), 'u')
                            .replaceAll(RegExp(r'ē'), 'e')
                            .replaceAll(RegExp(r'ō'), 'o')
                            .replaceAll(RegExp(r'ī'), 'i')
                      });
                      print(cityValue);
                    } else {
                      return;
                    }
                    BlocProvider.of<DataBloc>(context).add(Getdata());

                    Navigator.pop(context);
                  },
                  child: const Text("Save")))
        ],
      ),
    );
  }
}

class HeadTextLocation extends StatelessWidget {
  const HeadTextLocation({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            color: primary, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
