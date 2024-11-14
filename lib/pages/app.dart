import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Импорт Provider
import 'package:food_lis/providers/data_provider.dart'; // Импорт вашего DataProvider
import 'categories.dart';
import 'map.dart';
import 'chel.dart';
import 'profile.dart';
import 'package:food_lis/widgets/bottom_navbar.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  int _mapIndex = 0;
  late List<Widget> _pages;

  void onAllRest() {
    setState(() {
      _pages[1] =
          MapScreen(initialIndex: 1, data: []); // Обновляем индекс карты
      _onItemTapped(1); // Переходим на экран карты
    });
  }

  @override
  void initState() {
    super.initState();

    // Вызываем загрузку данных при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fetchRestaurantData();
    });

    // Инициализируем список экранов
    _pages = [
      Categoires(
        onSearch: () {
          // _onItemTapped(1);
        },
        onAllRest: onAllRest,
      ),
      MapScreen(
          key: ValueKey<int>(_mapIndex),
          initialIndex: _mapIndex,
          data: const []), // Обновляем MapScreen с новым ключом
      const Chel(),
      const Profile(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
