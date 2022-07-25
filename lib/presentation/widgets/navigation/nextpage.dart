import 'package:flutter/material.dart';

nextPage({required context, required page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => page)));
}

pushRemove({required context, required page}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_) => page), (route) => false);
}
