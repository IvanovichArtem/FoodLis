import 'package:flutter/material.dart';
import 'categories.dart';
import 'map.dart';
import 'chel.dart';
import 'profile.dart';
import 'package:food_lis/widgets/bottom_navbar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final List<Widget> _pages = [
    Categoires(),
    Map(),
    Chel(),
    Profile(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _pages,
          physics:
              const NeverScrollableScrollPhysics(), // Чтобы отключить свайпы
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 247, 247, 247),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
