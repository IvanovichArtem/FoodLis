import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Не забудьте добавить эту библиотеку
import 'package:firebase_storage/firebase_storage.dart'; // Не забудьте добавить эту библиотеку
import 'package:food_lis/pages/map.dart'; // Импортируйте ваш экран с картой

class SearchMapBar extends StatefulWidget {
  const SearchMapBar({super.key});

  @override
  State<SearchMapBar> createState() => _SearchMapBarState();
}

class _SearchMapBarState extends State<SearchMapBar> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchDatabase(String text) async {
    // Получаем все данные из коллекции 'restaraunts'
    final querySnapshot =
        await FirebaseFirestore.instance.collection('restaraunts').get();

    // Приводим введённый текст к нижнему регистру и убираем лишние пробелы
    final trimmedLowerText = text.trim().toLowerCase();

    // Фильтруем данные на стороне клиента, приводя 'name' к нижнему регистру
    final filteredDocs = querySnapshot.docs.where((doc) {
      final nameLower = doc['name'].toString().toLowerCase();
      return nameLower.contains(trimmedLowerText);
    }).toList();

    // Перебираем отфильтрованные документы и получаем URL изображений
    final List<Map<String, dynamic>> searchResults = [];
    for (var doc in filteredDocs) {
      final data = doc.data();
      final imagePath = data['imageUrl']; // Извлекаем путь к изображению

      // Получаем полный URL изображения из Firebase Storage
      final imageUrl =
          await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

      // Обновляем данные с правильной ссылкой на изображение
      searchResults.add({
        'documentId': doc.id,
        ...data,
        'imageUrl': imageUrl, // Заменяем путь на полный URL
      });
    }

    // Обновляем состояние с результатами поиска
    setState(() {
      _searchResults = searchResults;
    });
  }

  void _onSearchResultTap(Map<String, dynamic> restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialIndex: 0,
          data: _searchResults,
        ),
      ),
    );
  }

  void _handleSubmit() {
    final searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      _searchDatabase(searchText).then((_) {
        if (_searchResults.isNotEmpty) {
          _onSearchResultTap(_searchResults.first);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('По вашему запросу нет данных')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 36,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Поиск',
          hintStyle: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 138, 138, 142)),
          prefixIcon: const Icon(Icons.search,
              color: Color.fromARGB(255, 138, 138, 142)),
          filled: true,
          fillColor: const Color.fromARGB(255, 235, 235, 235),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        ),
        style: GoogleFonts.montserrat(fontSize: 14),
        onChanged: (String value) {
          // Вызываем поиск при изменении текста
          _searchDatabase(value);
        },
        onSubmitted: (value) => _handleSubmit(),
      ),
    );
  }
}
