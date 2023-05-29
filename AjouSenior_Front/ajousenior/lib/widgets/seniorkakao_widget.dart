import 'package:ajousenior/screen/senior_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeniorKakao extends StatelessWidget {
  const SeniorKakao({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeniorScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(8, 8))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 150,
        width: 200,
        child: Text('SeniorKakao',
            style: GoogleFonts.notoSansKannada(
              fontSize: 40,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
