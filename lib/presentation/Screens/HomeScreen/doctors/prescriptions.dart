import 'package:doctorbuddy/domain/colors.dart';
import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Prescriptions",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        foregroundColor: primary,
        backgroundColor: background,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: whiteColor),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paracetamol 650',
                      style: TextStyle(
                          color: primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Usage:')),
                        Expanded(flex: 2, child: Text('2 times after food')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Duration:')),
                        Expanded(flex: 2, child: Text('3 days')),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text('Remarks:')),
                        Expanded(flex: 2, child: Text('')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
