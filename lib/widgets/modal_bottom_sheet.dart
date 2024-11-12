import 'package:flutter/material.dart';
import 'package:food_lis/widgets/bottom_sheet/receipt.dart';
import 'package:food_lis/widgets/bottom_sheet/kitchens.dart';
import 'package:food_lis/widgets/bottom_sheet/restaraunt_type.dart';
import 'package:food_lis/widgets/bottom_sheet/distance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:location/location.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return _BottomSheetContent();
    },
  );
}

class _BottomSheetContent extends StatefulWidget {
  @override
  __BottomSheetContentState createState() => __BottomSheetContentState();
}

class __BottomSheetContentState extends State<_BottomSheetContent> {
  final GlobalKey<ReceiptWidgetState> receiptKey =
      GlobalKey<ReceiptWidgetState>();
  final GlobalKey<KitchensFilterWidgetState> kitchensKey =
      GlobalKey<KitchensFilterWidgetState>();
  final GlobalKey<MultipleToogleWidgetState> restaurantTypeKey =
      GlobalKey<MultipleToogleWidgetState>();
  final GlobalKey<MultipleToogleWidgetRatingState> ratingKey =
      GlobalKey<MultipleToogleWidgetRatingState>();
  final GlobalKey<DistanceWidgetState> distanceKey =
      GlobalKey<DistanceWidgetState>();
  final GlobalKey<KitchensFilterWidget2State> dayTimeKey =
      GlobalKey<KitchensFilterWidget2State>();
  final GlobalKey<MultipleToogleWidgetWithIconsState> featuresKey =
      GlobalKey<MultipleToogleWidgetWithIconsState>();
  final GlobalKey<MultipleToogleWidgetRestrictionsState> restrictionsKey =
      GlobalKey<MultipleToogleWidgetRestrictionsState>();

  double receiptStartValue = 10.0;
  double receiptEndValue = 50.0;
  bool isYandexSelected = false;
  bool isDeliverySelected = false;
  bool isRestaurantSelected = false;
  bool isTodaySelected = false;
  bool isTomorrowSelected = false;

  @override
  void initState() {
    super.initState();
  }

  void resetStates() {
    setState(() {
      receiptStartValue = 10.0;
      receiptEndValue = 50.0;
      isYandexSelected = false;
      isDeliverySelected = false;
      isRestaurantSelected = false;
      isTodaySelected = false;
      isTomorrowSelected = false;
    });

    // // Reset each widget via its key
    receiptKey.currentState?.reset(receiptStartValue, receiptEndValue);
    kitchensKey.currentState?.reset();
    restaurantTypeKey.currentState?.reset();
    ratingKey.currentState?.reset();
    distanceKey.currentState?.reset();
    dayTimeKey.currentState?.reset();
    featuresKey.currentState?.reset();
    ratingKey.currentState?.reset();
    restrictionsKey.currentState?.reset();
  }

  Future<List<Map<String, dynamic>>> fetchRestaurantsFromFirebase() async {
    // Получение текущего местоположения пользователя с использованием пакета location
    Location location = Location();
    LocationData userLocation = await location.getLocation();

    double userLatitude = userLocation.latitude ?? 0.0;
    double userLongitude = userLocation.longitude ?? 0.0;

    // Получаем данные о ресторанах из Firebase
    var snapshot =
        await FirebaseFirestore.instance.collection('restaraunts').get();

    // Преобразуем документы в List<Map<String, dynamic>> и добавляем расстояние
    List<Map<String, dynamic>> restaurantsWithDistance =
        snapshot.docs.map((doc) {
      Map<String, dynamic> restaurantData = doc.data() as Map<String, dynamic>;

      // Получаем координаты ресторана
      double restaurantLatitude = restaurantData['location'].latitude;
      double restaurantLongitude = restaurantData['location'].longitude;

      // Вычисляем расстояние между точками (в километрах)
      double distanceInKm = _calculateDistance(
          userLatitude, userLongitude, restaurantLatitude, restaurantLongitude);

      // Добавляем расстояние к данным ресторана
      restaurantData['distance'] = distanceInKm;

      return restaurantData;
    }).toList();

    return restaurantsWithDistance;
  }

// Функция для вычисления расстояния между двумя точками по формуле Haversine
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Радиус Земли в километрах

    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);

    double dlat = lat2Rad - lat1Rad;
    double dlon = lon2Rad - lon1Rad;

    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dlon / 2) * sin(dlon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Расстояние в километрах
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<void> filter() async {
    // Получаем состояние всех виджетов в одном Map
    Map<String, dynamic> currentState = {
      'receipt': receiptKey.currentState?.getCurrentState(),
      'kitchens': kitchensKey.currentState?.getCurrentState(),
      'restaraunt': restaurantTypeKey.currentState?.getCurrentState(),
      'rating': ratingKey.currentState?.getCurrentState(),
      'distance': distanceKey.currentState?.getCurrentState(),
      'dayTime': dayTimeKey.currentState?.getCurrentState(),
      'features': featuresKey.currentState?.getCurrentState(),
      'restrictions': restrictionsKey.currentState?.getCurrentState(),
    };

    List<String> selectedKitchens = currentState['kitchens'] ?? [];
    List<String> selectedRestaurants = currentState['restaraunt']
        .keys
        .where((key) => currentState['restaraunt'][key] == true)
        .toList();

    List<Map<String, dynamic>> restaurants =
        await fetchRestaurantsFromFirebase();
    print('');
    restaurants = restaurants.where((restaurant) {
      double avgPrice = restaurant['avgPrice']?.toDouble() ?? 0.0;
      return avgPrice >= currentState['receipt'][0] &&
          avgPrice <= currentState['receipt'][1];
    }).toList();

    if (selectedKitchens.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        String kitchenType = restaurant['kitchenType'] ?? '';
        // Проверяем, что kitchenType ресторана есть в selectedKitchens
        return selectedKitchens.contains(kitchenType);
      }).toList();
    }

    if (selectedRestaurants.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        String restaurantType = restaurant['restarauntType'] ?? '';
        // Проверяем, что restaurantType ресторана есть в selectedRestaurants с значением true
        return selectedRestaurants.contains(restaurantType);
      }).toList();
    }

    List<String> selectedRatings = currentState['rating']
        .keys
        .where((key) => currentState['rating'][key] == true)
        .toList();

    if (selectedRatings.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        double avgReview = restaurant['avgReview']?.toDouble() ?? 0.0;

        bool matchRating = false;

        if (selectedRatings.contains('Превосходно') && avgReview > 4.5) {
          matchRating = true;
        } else if (selectedRatings.contains('Отлично') &&
            avgReview > 4.0 &&
            avgReview <= 4.5) {
          matchRating = true;
        } else if (selectedRatings.contains('Хорошо') &&
            avgReview > 3.0 &&
            avgReview <= 4.0) {
          matchRating = true;
        }

        return matchRating;
      }).toList();
    }

    restaurants = restaurants.where((restaurant) {
      double restaurantDistance =
          restaurant['distance']?.toDouble() ?? double.infinity;
      return restaurantDistance < currentState['distance'];
    }).toList();

    List<String> requiredFeatures = currentState['features']
        .keys
        .where((key) => currentState['features'][key] == true)
        .toList();

    if (requiredFeatures.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        Map<String, dynamic> restaurantFeatures = restaurant['features'] ?? {};
        // Проверяем, что все ключи из requiredFeatures равны true в restaurantFeatures
        return requiredFeatures
            .every((feature) => restaurantFeatures[feature] == true);
      }).toList();
    }

    List<String> restrictions = currentState['restrictions']
        .keys
        .where((key) => currentState['restrictions'][key] == true)
        .toList();

    if (restrictions.isNotEmpty) {
      restaurants = restaurants.where((restaurant) {
        Map<String, dynamic> restaurantFeatures =
            restaurant['restrictions'] ?? {};
        return restrictions
            .every((feature) => restaurantFeatures[feature] == true);
      }).toList();
    }

    print("Current States: $currentState");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReceiptWidget(
                    key: receiptKey,
                    startValue: receiptStartValue,
                    endValue: receiptEndValue,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  KitchensFilterWidget(
                    key: kitchensKey,
                    itemInRow: 3,
                    kitchenData: [
                      {
                        'name': 'Азиатская',
                        'imageUrl': 'assets/images/kitchens/азиатская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Итальянская',
                        'imageUrl':
                            'assets/images/kitchens/итальянская кухня_2.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Белорусская',
                        'imageUrl': 'assets/images/kitchens/белорусская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Грузинская',
                        'imageUrl': 'assets/images/kitchens/грузинская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Европейская',
                        'imageUrl': 'assets/images/kitchens/европейская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Американская',
                        'imageUrl': 'assets/images/kitchens/американская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Авторская',
                        'imageUrl': 'assets/images/kitchens/авторская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Смешанная',
                        'imageUrl': 'assets/images/kitchens/смешанная.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                      {
                        'name': 'Вегетарианская',
                        'imageUrl': 'assets/images/kitchens/вегетарианская.jpg',
                        'width': 102.0,
                        'height': 73.0,
                      },
                    ],
                  ),
                  MultipleToogleWidget(
                    key: restaurantTypeKey,
                    text: "Тип заведения",
                    buttonsData: [
                      {'name': 'Ресторан', 'isSelected': false},
                      {'name': 'Кафе', 'isSelected': false},
                      {'name': 'Бар', 'isSelected': false},
                      {'name': 'Кофейня', 'isSelected': false},
                      {'name': 'Чайная', 'isSelected': false},
                      {'name': 'Кондитерская', 'isSelected': false},
                      {'name': 'Бистро', 'isSelected': false},
                      {'name': 'Фастфуд', 'isSelected': false},
                      {'name': 'Фудкорт', 'isSelected': false},
                      {'name': 'Суши-бар', 'isSelected': false},
                      {'name': 'Караоке', 'isSelected': false},
                      {'name': 'Ночной клуб', 'isSelected': false},
                      {'name': 'Кальянная', 'isSelected': false},
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  MultipleToogleWidgetRating(
                    key: ratingKey,
                    text: "Рейтинг",
                    buttonsData: [
                      {'name': 'Хорошо', 'isSelected': false},
                      {'name': 'Отлично', 'isSelected': false},
                      {'name': 'Превосходно', 'isSelected': false},
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  DistanceWidget(key: distanceKey),
                  SizedBox(
                    height: 14,
                  ),
                  KitchensFilterWidget2(
                    key: dayTimeKey,
                    itemInRow: 4,
                    kitchenData: [
                      {
                        'name': 'Завтрак',
                        'imageUrl': 'assets/images/kitchens/Завтрак.jpg',
                        'width': 86.0,
                        'height': 86.0,
                      },
                      {
                        'name': 'Обед',
                        'imageUrl': 'assets/images/kitchens/Обед.jpg',
                        'width': 86.0,
                        'height': 86.0,
                      },
                      {
                        'name': 'Бранч',
                        'imageUrl': 'assets/images/kitchens/Бранч.jpg',
                        'width': 86.0,
                        'height': 86.0,
                      },
                      {
                        'name': 'Ужин',
                        'imageUrl': 'assets/images/kitchens/Ужин.jpg',
                        'width': 86.0,
                        'height': 86.0,
                      },
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MultipleToogleWidgetWithIcons(
                    key: featuresKey,
                    text: "Особенности",
                    buttonsData: [
                      {
                        'icon': Icons.wifi,
                        'name': 'Wi-fi',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.balcony,
                        'name': 'Терасса',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.local_parking,
                        'name': 'Парковка',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.child_care_outlined,
                        'name': 'С детьми',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.pets,
                        'name': 'Pet friendly',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.percent_outlined,
                        'name': 'Акции',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.notifications,
                        'name': 'Обслуживание',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.wheelchair_pickup,
                        'name': 'Для инвалидов',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.delivery_dining,
                        'name': 'Доставка',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.music_note_rounded,
                        'name': 'Live музыка',
                        'isSelected': false
                      },
                      {
                        'icon': Icons.access_time,
                        'name': '24 часа',
                        'isSelected': false
                      },
                    ],
                  ),
                  const SizedBox(height: 10),
                  MultipleToogleWidgetRestrictions(
                    key: restrictionsKey,
                    text: "Ограничения",
                    buttonsData: [
                      {'name': 'Веганы', 'isSelected': false},
                      {'name': 'Вегетарианцы', 'isSelected': false},
                      {'name': 'Халяль', 'isSelected': false},
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: resetStates,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 243, 175, 79),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Center(
                        child: Text(
                          "Сбросить",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 243, 175, 79),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      filter();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 175, 79),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Center(
                        child: Text(
                          "Применить",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
