import 'package:ajousenior/screen/map_sample.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JuniorVolunteer extends StatelessWidget {
  const JuniorVolunteer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MapScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(3, 3))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 150,
        width: 200,
        child: Text('봉사',
            style: GoogleFonts.notoSansKannada(
              fontSize: 30,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
