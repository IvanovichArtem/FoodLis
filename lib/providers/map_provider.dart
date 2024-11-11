import 'package:flutter/material.dart';

class MapProvider with ChangeNotifier {
  int initialIndex = 1;
  List<dynamic> data = [];

  // Вы можете добавить методы для управления состоянием карты
  void updateData(List<dynamic> newData) {
    data = newData;
    notifyListeners();
  }
}
