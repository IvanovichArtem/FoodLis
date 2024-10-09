import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/pages/map.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> restaurantData = [
    {
      'imageUrl': 'assets/images/restaraunts/мамомимо.jpg',
      'name': 'Мамомимо',
      'restType': 'Ресторан итальянской кухни',
      'meanScore': 4.7,
      'reviewsCount': 19,
      'minutesToRest': 5,
      'meanCost': 25,
      'isToogle': true,
    },
    {
      'imageUrl': 'assets/images/restaraunts/престиж.jpg',
      'name': 'Престиж',
      'restType': 'Ресторан французской кухни',
      'meanScore': 4.5,
      'reviewsCount': 21,
      'minutesToRest': 5,
      'meanCost': 30,
      'isToogle': false,
    },
    {
      'imageUrl': 'assets/images/restaraunts/у веры.jpg',
      'name': 'У Веры',
      'restType': 'Ресторан белорусской кухни',
      'meanScore': 5.0,
      'reviewsCount': 99,
      'minutesToRest': 3,
      'meanCost': 25,
      'isToogle': true,
    },
    {
      'imageUrl': 'assets/images/restaraunts/greeny.jpg',
      'name': 'Greeny',
      'restType': 'Ресторан',
      'meanScore': 4.9,
      'reviewsCount': 43,
      'minutesToRest': 5,
      'meanCost': 30,
      'isToogle': false,
    },
  ];

  List<Map<String, dynamic>> _searchResults = [];

  void _searchDatabase(String text) {
    setState(() {
      _searchResults = restaurantData.where((restaurant) {
        final name = restaurant['name'] as String;
        return name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    });
  }

  void _onSearchResultTap(Map<String, dynamic> restaurant) {
    // Открытие MapScreen с результатами поиска
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialIndex: 0, // Здесь можете установить нужный индекс
          data: _searchResults, // Передаём найденные данные
        ),
      ),
    );
  }

  void _handleSubmit() {
    final searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      // Ищем результаты и затем вызываем _onSearchResultTap
      _searchDatabase(searchText);
      // Вызываем метод на первом найденном элементе
      if (_searchResults.isNotEmpty) {
        _onSearchResultTap(_searchResults.first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Поиск',
            hintStyle: GoogleFonts.montserrat(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10.0), // Уменьшаем вертикальное значение
          ),
          style:
              GoogleFonts.montserrat(fontSize: 14), // Установите размер текста
          onChanged: (String value) {
            _searchDatabase(value);
          },
          onSubmitted: (value) => _handleSubmit(), // Вызываем _handleSubmit
        ),
      ],
    );
  }
}
