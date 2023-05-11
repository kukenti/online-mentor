import 'package:flutter/material.dart';
import 'package:online_mentor/blocs/auth/auth_cubit.dart';
import 'package:online_mentor/screens/home_screen/home_screen.dart';
import 'package:online_mentor/screens/login_screen/login_screen.dart';
import 'package:online_mentor/screens/profile/profile_screen.dart';
import 'package:online_mentor/service_locator.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online mentor'),
        actions: [
          GestureDetector(
            onTap: () {
              getIt<AuthCubit>().signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
