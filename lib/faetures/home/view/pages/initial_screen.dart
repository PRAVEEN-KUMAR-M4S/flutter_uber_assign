import 'package:flutter/material.dart';
import 'package:uber_clone/faetures/home/view/pages/bookings_screen.dart';
import 'package:uber_clone/faetures/home/view/pages/home_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const BookingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book_online),label: '')
        ],
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
      ),
    );
  }
}
