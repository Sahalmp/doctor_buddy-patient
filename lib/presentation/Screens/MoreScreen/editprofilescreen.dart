import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/application/datafetch/data_bloc.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
import 'package:doctorbuddy/presentation/widgets/navigation/backbutton.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/details/details_bloc.dart';
import '../../../domain/colors.dart';
import '../../../domain/constants.dart';
import '../registration/widgets/radiobuttonwidget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  String image = "";
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailsBloc>(context).add(Getimage(image: null));

    BlocProvider.of<DataBloc>(context).add(Getdata());

    final Size devSize = MediaQuery.of(context).size;
    DateTime selectedDate = DateTime.now();
    String? imageprofile;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        foregroundColor: primary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              String dropdownValue = state.userModel!.bloodgroup!;
              imageprofile = state.userModel!.image;

              _nameController.text = state.userModel!.name!;
              _dobController.text = state.userModel!.dob!;
              return Column(
                children: [
                  gheight_20,
                  BlocBuilder<DetailsBloc, DetailsState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          state.image == null
                              ? imageprofile != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(imageprofile!),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.blueGrey.shade100,
                                      child: const Icon(Icons.person),
                                    )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      FileImage(File("${state.image}")),
                                ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: InkWell(
                                onTap: () async {
                                  XFile? img = await _imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (img != null) {
                                    image = img.path;
                                    BlocProvider.of<DetailsBloc>(context)
                                        .add(Getimage(image: image));
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: primary,
                                  child: Icon(
                                    Icons.camera_alt,
                                  ),
                                )),
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gheight_30,
                            const Text(
                              'Full name',
                              style: TextStyle(color: primary),
                            ),
                            TextFormField(
                                validator: (value) {
                                  return value == null || value.length < 4
                                      ? "Enter valid name(min 4 char)"
                                      : null;
                                },
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: primary)),
                                  hintText: 'Enter the name',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: primary,
                                  ),
                                )),
                            gheight_30,
                            const Text(
                              'Gender',
                              style: TextStyle(color: primary),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RadioButtonWidget(
                                    valuename: 'Male',
                                    editgender: state.userModel!.gender),
                                RadioButtonWidget(
                                    valuename: 'Female',
                                    editgender: state.userModel!.gender),
                                RadioButtonWidget(
                                    valuename: 'Other',
                                    editgender: state.userModel!.gender),
                              ],
                            ),
                            FormField(validator: (value) {
                              if (gender == null || gender.isEmpty) {
                                return 'Gender cannot be empty.';
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
                            gheight_30,
                            const Text(
                              'DOB',
                              style: TextStyle(color: primary),
                            ),
                            BlocBuilder<DetailsBloc, DetailsState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      child: TextFormField(
                                        onTap: () {},
                                        readOnly: true,
                                        validator: (value) {
                                          return value == null || value.isEmpty
                                              ? "Date of Birth Required "
                                              : null;
                                        },
                                        controller: _dobController,
                                        decoration: const InputDecoration(
                                          hintText: 'DD/MM/YYYY',
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final selected = await showDatePicker(
                                              initialDate: state.date,
                                              firstDate: DateTime(1910),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 1),
                                              context: context);
                                          if (selected != null &&
                                              selected != selectedDate) {
                                            // selectedDate = selected;
                                            BlocProvider.of<DetailsBloc>(
                                                    context)
                                                .add(GetDate(date: selected));
                                            _dobController.text =
                                                "${state.date.day}/${state.date.month}/${state.date.year}";
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.date_range_outlined))
                                  ],
                                );
                              },
                            ),
                            gheight_40,
                            const Text(
                              'Blood Group',
                              style: TextStyle(color: primary),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.bloodtype_outlined,
                                ),
                                gwidth_10,
                                SizedBox(
                                  width: devSize.width * 0.30,
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      return value == null || value.isEmpty
                                          ? "Blood Group required"
                                          : null;
                                    },
                                    isDense: true,
                                    isExpanded: true,
                                    menuMaxHeight: 200,
                                    disabledHint: const Text("dropdownValue"),
                                    value: dropdownValue.isEmpty
                                        ? null
                                        : dropdownValue,
                                    onChanged: (value) {
                                      dropdownValue = value.toString();
                                    },
                                    items: <String>[
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'O+',
                                      'O-',
                                      'AB+',
                                      'AB-'
                                    ].map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
        child: Row(
          children: [
            Expanded(child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    
                    if (formKey.currentState!.validate()) {
                      print('++++++++++++++++++++');

                      String? imgurl;
                      if (state.image != null) {
                        String imagename =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        TaskSnapshot uploadTask = await FirebaseStorage.instance
                            .ref('patients/$imagename')
                            .putFile(File(image));
                        imgurl = await uploadTask.ref.getDownloadURL();
                      } else {
                        imgurl = imageprofile!;
                      }
                      print(imgurl);
                      await FirebaseFirestore.instance
                          .collection('pusers')
                          .doc(auth.currentUser!.uid)
                          .update({
                        'name': _nameController.text,
                        'gender': gender,
                        'dob': _dobController.text,
                        'bloodgroup': dropdownValue,
                        'image': imgurl
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Save'),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
