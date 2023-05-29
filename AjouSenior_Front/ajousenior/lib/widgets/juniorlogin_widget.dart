import 'package:ajousenior/screen/juniorlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JuniorLogin extends StatelessWidget {
  const JuniorLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JuniorLoginScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 20, 146, 9).withOpacity(0.3),
                offset: const Offset(6, 6))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 150,
        width: 180,
        child: Text('Junior',
            style: GoogleFonts.notoSansKannada(
              fontSize: 40,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
