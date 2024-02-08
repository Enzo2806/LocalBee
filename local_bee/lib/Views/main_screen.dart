import 'package:flutter/material.dart';
import 'package:local_bee/Views/quiz_view/quiz_view.dart';
// Import your view screens
// import 'search_store_view.dart';
// import 'profile_view.dart';
// import 'quiz_view.dart';
// import 'settings_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Default index of the first screen

  // List of widgets to call on tab tap.
  final List<Widget> _widgetOptions = [
    QuizView(), // Placeholder for QuizView()
    const Text('Search Store'), // Placeholder for SearchStoreView()
    const Text('Profile'), // Placeholder for ProfileView()
    const Text('Settings'), // Placeholder for SettingsView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
