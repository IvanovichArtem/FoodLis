import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _restaurantData = [];

  List<Map<String, dynamic>> get restaurantData => _restaurantData;

  void updateRestaurantData(List<Map<String, dynamic>> newData) {
    _restaurantData.addAll(newData);
    notifyListeners(); // Обновление всех слушателей
  }

  // Функция для получения данных ресторанов
  Future<void> fetchRestaurantData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not authenticated');
        return;
      }

      final querySnapshot =
          await FirebaseFirestore.instance.collection('restaraunts').get();

      _restaurantData = []; // Очистка перед обновлением данных

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final storagePath = data['imageUrl'];
        if (storagePath == null || storagePath.isEmpty) {
          continue;
        }

        // Получаем URL изображения из Firebase Storage
        final downloadUrl =
            await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

        final userDocId = '${user.uid}_${doc.id}';
        final userRestDoc = await FirebaseFirestore.instance
            .collection('user_rest')
            .doc(userDocId)
            .get();

        bool isToogle =
            userRestDoc.exists ? userRestDoc['isBookmarked'] : false;

        // Создаем структуру для ресторана, динамически заполняя её из данных документа
        final Map<String, dynamic> restaurantEntry = {};

        // Копируем все ключи и значения из документа
        for (var key in data.keys) {
          restaurantEntry[key] = data[key];
        }

        // Добавляем URL изображения и статус закладки
        restaurantEntry['imageUrl'] = downloadUrl;
        restaurantEntry['isToogle'] = isToogle;
        restaurantEntry['id'] = doc.id;

        _restaurantData.add(restaurantEntry);
      }

      // Уведомляем слушателей об изменениях данных
      notifyListeners();
    } catch (e) {
      print('Error fetching restaurant data: $e');
    }
  }
}
