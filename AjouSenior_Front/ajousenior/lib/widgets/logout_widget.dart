import 'package:ajousenior/screen/mainlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  static const storage = FlutterSecureStorage();

  logout() async {
    await storage.delete(key: 'login');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logout();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainLogin(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1, 1))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 30,
        width: 70,
        child: Text('로그아웃',
            style: GoogleFonts.notoSansKannada(
              fontSize: 15,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
