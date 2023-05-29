import 'package:ajousenior/widgets/juniorcurrent_widget.dart';
import 'package:ajousenior/widgets/juniorvolunteer_widget.dart';
import 'package:flutter/material.dart';

class JuniorHomeScreen extends StatelessWidget {
  const JuniorHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "Junior App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                JuniorVolunteer(),
                SizedBox(
                  height: 20,
                ),
                JuniorCurrent(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
