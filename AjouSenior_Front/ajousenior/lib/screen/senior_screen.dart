import 'package:ajousenior/screen/seniorhome_screen.dart';
import 'package:ajousenior/screen/myprofile_screen.dart';
import 'package:ajousenior/screen/temp_screen.dart';
import 'package:flutter/material.dart';

class SeniorScreen extends StatefulWidget {
  const SeniorScreen({super.key});

  @override
  State<SeniorScreen> createState() => _SeniorScreenState();
}

class _SeniorScreenState extends State<SeniorScreen> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const TempScreen(),
    const SeniorHomeScreen(),
    const MyProfileScreen(),
  ];

  void _onTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
