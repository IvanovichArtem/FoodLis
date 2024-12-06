import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchMapBar extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onSearchResultsUpdated;

  const SearchMapBar({
    super.key,
    required this.onSearchResultsUpdated,
  });

  @override
  State<SearchMapBar> createState() => _SearchMapBarState();
}

class _SearchMapBarState extends State<SearchMapBar> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchDatabase(String text) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('restaraunts').get();

    final trimmedLowerText = text.trim().toLowerCase();
    final filteredDocs = trimmedLowerText.isEmpty
        ? querySnapshot.docs // Вернём все документы, если строка поиска пустая
        : querySnapshot.docs.where((doc) {
            final nameLower = doc['name'].toString().toLowerCase();
            return nameLower.contains(trimmedLowerText); // Фильтрация по тексту
          }).toList();
    final List<Map<String, dynamic>> searchResults = filteredDocs.map((doc) {
      return {
        'id': doc.id,
      };
    }).toList();

    // Вызываем функцию обратного вызова для обновления результатов поиска
    widget.onSearchResultsUpdated(searchResults);
  }

  void _handleSubmit() {
    final searchText = _searchController.text;
    _searchDatabase(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 280,
        height: 36,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Поиск',
            hintStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 114, 114, 114),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 114, 114, 114),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 200, 200, 200),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 200, 200, 200),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 200, 200, 200),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          ),
          style: GoogleFonts.montserrat(fontSize: 14),
          onSubmitted: (value) => _handleSubmit(),
        ));
  }
}
