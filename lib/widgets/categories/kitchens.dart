import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_lis/pages/map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/providers/data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KitchenItem extends StatefulWidget {
  final String name;
  final double height;
  final double width;
  final String field;
  final String id;

  const KitchenItem({
    super.key,
    required this.name,
    required this.width,
    required this.height,
    required this.field,
    required this.id,
  });

  @override
  _KitchenItemState createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  String? imageUrl;
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false; // Новый флаг для отображения загрузки

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  void fetchImage() {
    setState(() {
      imageUrl = 'assets/images/kitchens/${widget.name}.jpg';
    });
  }

  Future<void> fetchDataFromDataProvider() async {
    final dataProvider = DataProvider(); // Initialize the DataProvider

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    await dataProvider.fetchRestaurantData(); // Fetch data from Firestore

    final List<Map<String, dynamic>> dataFromProvider =
        dataProvider.restaurantData;
    final List<Map<String, dynamic>> results = [];

    for (var data in dataFromProvider) {
      data['isVisible'] = true;

      if (widget.field == 'x') {
        data['isVisible'] = false;
        results.add(data);
      } else if (widget.field == 'features') {
        if (data['features'] != null && data['features'][widget.id] == true) {
          results.add(data);
        }
      } else if (widget.field == 'kitchenType') {
        if (data['kitchenType'] == widget.id) {
          results.add(data);
        }
      }
    }

    setState(() {
      _searchResults = results;
      _isLoading = false; // Hide loading indicator
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialIndex: 1,
          data: _searchResults,
          isSearch: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _isLoading
              ? null
              : fetchDataFromDataProvider, // Блокируем повторный клик
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imageUrl ?? 'assets/placeholder.jpg',
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                ),
                if (_isLoading) // Отображаем индикатор загрузки поверх изображения
                  CircularProgressIndicator(
                    color: Color.fromARGB(255, 243, 175, 79),
                  ),
              ],
            ),
          ),
        ),
        Text(
          widget.name,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
