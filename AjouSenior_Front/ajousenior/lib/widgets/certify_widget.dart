import 'package:ajousenior/widgets/applylist_widget.dart';
import 'package:flutter/material.dart';

class CertifyWidget extends StatelessWidget {
  final String donationid;
  const CertifyWidget({
    super.key,
    required this.donationid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('인증하기'),
              content: ApplyListWidget(
                donationid: donationid,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 창 닫기
                  },
                  child: const Text('닫기'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(45),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Text(
            "인증하기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
