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
  late List<Widget> _pages;

  void onAllRest() {
    setState(() {
      _pages[1] = MapScreen(
        initialIndex: 1,
        data: [],
        isSearch: false,
      ); // Обновляем индекс карты
      _onItemTapped(1); // Переходим на экран карты
    });
  }

  void onSearch() {
    setState(() {
      _pages[1] = MapScreen(
        initialIndex: 1,
        data: [],
        isSearch: true,
      ); // Обновляем индекс карты
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
        onSearch: onSearch,
        onAllRest: onAllRest,
      ),
      MapScreen(
        key: ValueKey<int>(0),
        initialIndex: 0,
        data: const [],
        isSearch: false,
      ), // Обновляем MapScreen с новым ключом
      const Chel(),
      const Profile(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut, // Плавная анимация
    );
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
        physics: const NeverScrollableScrollPhysics(), // Отключаем свайпы
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
