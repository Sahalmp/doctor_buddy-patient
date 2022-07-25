import 'package:doctorbuddy/application/details/details_bloc.dart';
import 'package:doctorbuddy/domain/colors.dart';
import 'package:doctorbuddy/domain/constants.dart';
import 'package:doctorbuddy/presentation/Screens/registration/addmoredetails.dart';
import 'package:doctorbuddy/presentation/Screens/registration/widgets/radiobuttonwidget.dart';
import 'package:doctorbuddy/presentation/widgets/textwidgets/headtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/navigation/nextpage.dart';

// ignore: must_be_immutable
class AddDetails extends StatelessWidget {
  AddDetails({Key? key}) : super(key: key);
  String dropdownValue = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size devSize = MediaQuery.of(context).size;
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: devSize.width * 0.05),
        child: Form(
          key: formKey,
          child: ListView(children: [
            gheight_30,
            const HeadingText(text: 'Hi'),
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
                ),
                RadioButtonWidget(valuename: 'Female'),
                RadioButtonWidget(valuename: 'Other')
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
                              lastDate: DateTime(DateTime.now().year + 1),
                              context: context);
                          if (selected != null && selected != selectedDate) {
                            // selectedDate = selected;
                            BlocProvider.of<DetailsBloc>(context)
                                .add(GetDate(date: selected));
                            _dobController.text =
                                "${state.date.day}/${state.date.month}/${state.date.year}";
                          }
                        },
                        icon: const Icon(Icons.date_range_outlined))
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
                    value: dropdownValue.isEmpty ? null : dropdownValue,
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
            const SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      nextPage(
                          context: context,
                          page: AddMoreDetails(
                            dob: _dobController.text,
                            name: _nameController.text,
                            gender: gender,
                            bloodgroup: dropdownValue,
                          ));
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Next'),
                  ),
                )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
