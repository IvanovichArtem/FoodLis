import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final TextEditingController _searchController = TextEditingController();
  List _searchResults = [];

  void _searchDatabase() {
    databaseReference.child('items').orderByChild('name').equalTo(_searchController.text).once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        setState(() {
          _searchResults = snapshot.value.values.toList();
        });
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
          hintText: 'Поиск',
          hintStyle:
              GoogleFonts.roboto(color: Colors.grey), // Цвет текста подсказки
          prefixIcon:
              const Icon(Icons.search, color: Colors.grey), // Иконка поиска
          filled: true, // Включение фона
          fillColor: Colors.grey[300], // Цвет фона
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Скругление углов
            borderSide: BorderSide.none, // Убираем обводку
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Убираем обводку в обычном состоянии
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // Убираем обводку при фокусе
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5.0, horizontal: 8.0), // Настройка отступов
        ),
        onChanged: (text) {
          _searchDatabase();
        },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_searchResults[index]['name']),
              );
            },
          ),
        ),
      ],
    );
  }
}
