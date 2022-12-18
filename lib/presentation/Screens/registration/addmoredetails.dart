import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/Mainscreen/mainscreen.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/backbutton.dart';
import 'package:doctorbuddy/presentation/widgets/textwidgets/headtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/colors.dart';
import '../../../domain/user/usermodel.dart';
import '../../widgets/navigation/nextpage.dart';

class AddMoreDetails extends StatelessWidget {
  AddMoreDetails(
      {Key? key,
      required this.name,
      required this.dob,
      required this.gender,
      required this.bloodgroup})
      : super(key: key);
  final String name;
  final String dob;
  final String gender;
  final String bloodgroup;
  final _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? countryValue = "";

  String? stateValue = "";

  String? cityValue = "";
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
          child: ListView(children: [
            const BackButtonWidget(),
            gheight_20,
            HeadingText(text: 'Hi,\n ${name}'),
            gheight_30,
            const Text(
              'Address',
              style: TextStyle(color: primary),
            ),
            TextFormField(
                validator: (value) {
                  return value == null || value.isEmpty
                      ? "Enter valid address"
                      : null;
                },
                controller: _addressController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary)),
                  hintText: 'Enter the Address',
                  prefixIcon: Icon(
                    Icons.home,
                    color: primary,
                  ),
                )),
            gheight_30,
            CSCPicker(
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
            FormField(validator: (value) {
              if (countryValue == "" || stateValue == "" || cityValue == "") {
                return 'place cannot be empty.';
              }
              return null;
            }, builder: (radiostate) {
              return Text(
                radiostate.errorText ?? '',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
                textAlign: TextAlign.center,
              );
            }),
            gheight_50,
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postDetailsToFirebaseStore(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Submit'),
                  ),
                )),
              ],
            )
          ]),
        ),
      ),
    );
  }

  postDetailsToFirebaseStore(context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    PUserModel userModel = PUserModel(
      uid: user!.uid,
      place: cityValue,
      name: name,
      gender: gender,
      address: _addressController.text,
      bloodgroup: bloodgroup,
      dob: dob,
    );

    await firebaseFirestore
        .collection('pusers')
        .doc(user.uid)
        .set(userModel.toMap());
    await firebaseFirestore
        .collection('pusers')
        .doc(user.uid)
        .update({'Wallet': 0});
    nextPage(context: context, page: MainScreen());
  }
}
