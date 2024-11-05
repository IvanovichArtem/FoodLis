import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Не забудьте добавить эту библиотеку
import 'package:firebase_storage/firebase_storage.dart'; // Не забудьте добавить эту библиотеку
import 'package:food_lis/pages/map.dart'; // Импортируйте ваш экран с картой

class SearchMapBar extends StatefulWidget {
  final Function(List<Map<String, dynamic>>)
      onSearchResultsUpdated; // Функция обратного вызова для обновления результатов

  const SearchMapBar(
      {super.key,
      required this.onSearchResultsUpdated}); // Добавьте параметр конструктора

  @override
  State<SearchMapBar> createState() => _SearchMapBarState();
}

class _SearchMapBarState extends State<SearchMapBar> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchDatabase(String text) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('restaraunts').get();

    final trimmedLowerText = text.trim().toLowerCase();

    final filteredDocs = querySnapshot.docs.where((doc) {
      final nameLower = doc['name'].toString().toLowerCase();
      return nameLower.contains(trimmedLowerText);
    }).toList();

    final List<Map<String, dynamic>> searchResults = [];
    for (var doc in filteredDocs) {
      final data = doc.data();
      final imagePath = data['imageUrl'];

      final imageUrl =
          await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

      searchResults.add({
        'documentId': doc.id,
        ...data,
        'imageUrl': imageUrl,
      });
    }

    // Вызываем функцию обратного вызова для обновления результатов в MapScreen
    widget.onSearchResultsUpdated(searchResults);
  }

  void _handleSubmit() {
    final searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      _searchDatabase(searchText);
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
        // onChanged: (String value) {
        //   _searchDatabase(value);
        // },
        onSubmitted: (value) => _handleSubmit(),
      ),
    );
  }
}
