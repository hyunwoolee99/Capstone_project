import 'package:flutter/material.dart';

class OnRecruit extends StatelessWidget {
  final bool full;

  const OnRecruit({super.key, required this.full});
  @override
  Widget build(BuildContext context) {
    if (!full) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(45),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.5,
            horizontal: 10,
          ),
          child: Text(
            '모집중',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w100),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(45),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.5,
            horizontal: 10,
          ),
          child: Text(
            '모집완료',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w200),
          ),
        ),
      );
    }
  }
}
