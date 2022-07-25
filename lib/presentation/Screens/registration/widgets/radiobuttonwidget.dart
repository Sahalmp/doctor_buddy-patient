import 'package:doctorbuddy/presentation/Screens/registration/adddetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/details/details_bloc.dart';

String gender = '';

class RadioButtonWidget extends StatelessWidget {
  final String valuename;
  String? editgender;
  RadioButtonWidget({Key? key, required this.valuename, this.editgender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editgender != null) {
      BlocProvider.of<DetailsBloc>(context).add(GetGender(gender: editgender));
    }
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      return Row(children: [
        Radio(
            value: valuename,
            groupValue: state.gender,
            onChanged: (value) {
              editgender = null;
              gender = valuename;
              editgender = valuename;
              context.read<DetailsBloc>().add(GetGender(gender: value));
            }),
        Text(valuename),
      ]);
    });
  }
}
