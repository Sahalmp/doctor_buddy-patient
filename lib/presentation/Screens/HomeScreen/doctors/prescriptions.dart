import 'package:doctorbuddy/domain/colors.dart';
import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({Key? key, required this.prescrdata})
      : super(key: key);
  final List prescrdata;

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
      body: ListView.builder(
          itemCount: prescrdata.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: whiteColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prescrdata[index]['drug'],
                        style: const TextStyle(
                            color: primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Usage:')),
                          Expanded(
                              flex: 2, child: Text(prescrdata[index]['usage'])),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Duration:')),
                          Expanded(
                              flex: 2,
                              child: Text(prescrdata[index]['duration'])),
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Remarks:')),
                          Expanded(
                              flex: 2,
                              child: Text(prescrdata[index]['remark'])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
