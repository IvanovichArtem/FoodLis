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
  int _navigationCount = 0; // Счетчик переходов
  late List<Widget> _pages;

  void onAllRest() {
    setState(() {
      _pages[1] = MapScreen(
        initialIndex: 1,
        data: [],
        isSearch: false,
      );
      _onItemTapped(1);
    });
  }

  void onSearch() {
    setState(() {
      _pages[1] = MapScreen(
        initialIndex: 1,
        data: [],
        isSearch: true,
      );
      _onItemTapped(1);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fetchRestaurantData();
    });

    _initPages();
  }

  void _initPages() {
    // Метод для инициализации всех страниц
    _pages = [
      Categoires(
        onSearch: onSearch,
        onAllRest: onAllRest,
      ),
      MapScreen(
        initialIndex: 0,
        data: const [],
        isSearch: false,
      ),
      Chel(),
      // Chel(isActive: _selectedIndex == 2),
      const Profile(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationCount++; // Увеличиваем счетчик переходов

      // Проверяем, если счетчик достиг 10
      if (_navigationCount >= 10) {
        // Обновляем данные и реинициализируем страницы
        Provider.of<DataProvider>(context, listen: false)
            .fetchRestaurantData()
            .then((_) {
          setState(() {
            _initPages(); // Реинициализируем страницы
            _navigationCount = 0; // Сбрасываем счетчик
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
