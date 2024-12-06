import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_lis/widgets/map/search_bar_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_modal.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:food_lis/widgets/map/list_item.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class MapScreen extends StatefulWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> data;
  final bool isSearch;

  const MapScreen({
    super.key,
    required this.initialIndex,
    required this.data,
    required this.isSearch,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> restarauntData = [];
  late YandexMapController _controller;
  LocationData? _currentLocation;
  List<MapObject> _mapObjects = [];
  String? _activeMarkerId = "";
  Map<String, dynamic> floatRest = {};
  Set<String> _searchResults = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    if (widget.data.isEmpty & !widget.isSearch) {
      _fetchRestaurants();
    } else {
      restarauntData = widget.data;
      _drawRestOnSearch();
    }
    _currentIndex = widget.initialIndex;
  }

  Future<void> _drawRestOnSearch() async {
    for (var doc in restarauntData) {
      try {
        final data = doc;

        double latitude = data['location'].latitude;
        double longitude = data['location'].longitude;
        String name = data['name'];
        double avgReview = data['avgReview'];
        int avgPrice = data['avgPrice'];

        if (data['isVisible']) {
          await _addRestaurantMarker(
              latitude,
              longitude,
              name,
              // Добавляем маркер на карту
              avgReview.toString(),
              avgPrice.toString(),
              data['id']);
        }
      } catch (e) {
        print('Ошибка при обработке документа: $e');
        continue;
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    PermissionStatus permissionGranted = await location.requestPermission();

    if (permissionGranted == PermissionStatus.granted) {
      _currentLocation = await location.getLocation();
      _addCurrentLocationMarker();
    } else {
      SnackBar(
          content: Text(
              "Доступ к местоположению ограничен. Разрешите доступ для получения данных о ресторанах рядом."));
    }
  }

  Future<String> _getTravelTime(
      double startLat, double startLng, double endLat, double endLng) async {
    double _degreesToRadians(double degrees) {
      return degrees * pi / 180;
    }

    const double avgSpeedKmPerHour = 35; // Средняя скорость в городе (км/ч)

    // Функция для вычисления расстояния между двумя точками (в километрах) используя Haversine формулу
    double _calculateDistance(
        double lat1, double lon1, double lat2, double lon2) {
      const double earthRadiusKm = 6371;

      final double dLat = _degreesToRadians(lat2 - lat1);
      final double dLon = _degreesToRadians(lon2 - lon1);

      final double a = sin(dLat / 2) * sin(dLat / 2) +
          cos(_degreesToRadians(lat1)) *
              cos(_degreesToRadians(lat2)) *
              sin(dLon / 2) *
              sin(dLon / 2);
      final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

      return earthRadiusKm * c;
    }

    // Вычисляем расстояние между начальной и конечной точкой
    final double distanceKm =
        _calculateDistance(startLat, startLng, endLat, endLng);

    // Рассчитываем примерное время в минутах
    final int travelTimeMinutes = (distanceKm / avgSpeedKmPerHour * 60).round();

    return "$travelTimeMinutes мин";
  }

  void _addCurrentLocationMarker() {
    if (_currentLocation != null) {
      final mapObject = PlacemarkMapObject(
          mapId: MapObjectId('current_location'),
          opacity: 1,
          point: Point(
            latitude: _currentLocation!.latitude!,
            longitude: _currentLocation!.longitude!,
          ),
          icon: PlacemarkIcon.composite([
            PlacemarkCompositeIconItem(
                name: '',
                style: PlacemarkIconStyle(
                    scale: 0.5,
                    image: BitmapDescriptor.fromAssetImage(
                        'assets/icons/current_location.png')))
          ]));

      setState(() {
        _mapObjects.add(mapObject);
      });
    }
  }

  Future<void> _fetchRestaurants() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('restaraunts').get();

    for (var doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>;

        double latitude = data['location'].latitude;
        double longitude = data['location'].longitude;
        String name = data['name'];
        double avgReview = data['avgReview'];
        int avgPrice = data['avgPrice'];
        int cntReviews = data['cntReviews'];
        Map deliveryInfo = data['deliveryinfo'];
        String startTime = data['startTime'];
        String endTime = data['endTime'];
        Map features = data['features'];
        Map restrictions = data['restrictions'];
        String videoUrl = data['videoUrl'];
        String restarauntType = data['restarauntType'];
        String imageUrlPath = data['imageUrl'];
        int stock = data['stock'];
        final user = FirebaseAuth.instance.currentUser;

        String imageUrl =
            await FirebaseStorage.instance.ref(imageUrlPath).getDownloadURL();
        final userDocId = '${user?.uid}_${doc.id}';

        // Streamlined isToogle retrieval
        final isToogle = (await FirebaseFirestore.instance
                    .collection('user_rest')
                    .doc(userDocId)
                    .get())
                .data()?['isBookmarked'] ??
            false;
        restarauntData.add({
          'id': doc.id,
          'name': name,
          'avgReview': avgReview,
          'avgPrice': avgPrice,
          'latitude': latitude,
          'longitude': longitude,
          'imageUrl': imageUrl,
          'cntReviews': cntReviews,
          'deliveryInfo': deliveryInfo,
          'startTime': startTime,
          'endTime': endTime,
          'features': features,
          'restrictions': restrictions,
          'videoUrl': videoUrl,
          'siteUrl': data['siteUrl'],
          'instaUrl': data['instaUrl'],
          'restarauntType': restarauntType,
          'isToogle': isToogle,
          'isVisible': true,
          'stock': stock
        });

        // Добавляем маркер на карту
        await _addRestaurantMarker(latitude, longitude, name,
            avgReview.toString(), avgPrice.toString(), doc.id);
      } catch (e) {
        print('Ошибка при обработке документа: $e');
        continue;
      }
    }
  }

  void _showAll({bool needState = true}) {
    if (widget.isSearch) {
      Navigator.pop(context);
      return;
    }

    if (needState) {
      setState(() {
        for (var rest in restarauntData) {
          rest['isVisible'] = true;
        }
      });
    } else {
      for (var rest in restarauntData) {
        rest['isVisible'] = true;
      }
    }
    _searchResults = {};
  }

  void _showStock() {
    _showAll();

    setState(() {
      for (int i = 0; i < restarauntData.length; i++) {
        restarauntData[i]['isVisible'] = restarauntData[i]['stock'] != 0;
      }
    });

    if (_currentIndex == 1) {
      return; // Ничего не делаем, если текущий индекс равен 1
    } else if (_currentIndex == 0) {
      var restaurant = restarauntData.last;
      floatRest = {
        'id': restaurant['id'],
        'name': restaurant['name'],
        'avgReview': restaurant['avgReview'],
        'avgPrice': restaurant['avgPrice'],
        'latitude': restaurant['latitude'],
        'longitude': restaurant['longitude'],
        'imageUrl': restaurant['imageUrl'],
        'cntReviews': restaurant['cntReviews'],
        'deliveryInfo': restaurant['deliveryInfo'],
        'startTime': restaurant['startTime'],
        'endTime': restaurant['endTime'],
        'features': restaurant['features'],
        'restrictions': restaurant['restrictions'],
        'videoUrl': restaurant['videoUrl'],
        'restarauntType': restaurant['restarauntType'],
        'isToogle': restaurant['isToogle'],
        'siteUrl': restaurant['siteUrl'],
        'instaUrl': restaurant['instaUrl']
      };
      _updateMarkerIcon(
          restaurant['id'], 'assets/icons/orange_location.png', 0.4);
    }
  }

  void _showBest() {
    _showAll();
    // Сортируем список restaurantData по ключу avgReview в порядке убывания
    setState(() {
      restarauntData.sort((a, b) {
        // Сравниваем значения avgReview для двух элементов
        return b['avgReview'].compareTo(a['avgReview']);
      });
    });
    if (_currentIndex == 1) {
      return; // Ничего не делаем, если текущий индекс равен 1
    } else if (_currentIndex == 0) {
      var restaurant = restarauntData.first;
      floatRest = {
        'id': restaurant['id'],
        'name': restaurant['name'],
        'avgReview': restaurant['avgReview'],
        'avgPrice': restaurant['avgPrice'],
        'latitude': restaurant['latitude'],
        'longitude': restaurant['longitude'],
        'imageUrl': restaurant['imageUrl'],
        'cntReviews': restaurant['cntReviews'],
        'deliveryInfo': restaurant['deliveryInfo'],
        'startTime': restaurant['startTime'],
        'endTime': restaurant['endTime'],
        'features': restaurant['features'],
        'restrictions': restaurant['restrictions'],
        'videoUrl': restaurant['videoUrl'],
        'restarauntType': restaurant['restarauntType'],
        'isToogle': restaurant['isToogle'],
        'siteUrl': restaurant['siteUrl'],
        'instaUrl': restaurant['instaUrl']
      };
      _updateMarkerIcon(
          restaurant['id'], 'assets/icons/orange_location.png', 0.4);
    }
  }

  void _showFilter(List filteredIds) {
    _showAll();

    setState(() {
      _currentIndex = 1;

      // Проходим по всем элементам restaurantData
      for (var restaurant in restarauntData) {
        // Проверяем, есть ли id ресторана в filteredIds
        if (!filteredIds.contains(restaurant['id'])) {
          // Если id нет в filteredIds, добавляем isVisible: false
          restaurant['isVisible'] = false;
        } else {
          // Если id есть в filteredIds, то оставляем isVisible как true или не меняем
        }
      }
    });
  }

  void _updateSearchResults(List<Map<String, dynamic>> searchResults) {
    _showAll(needState: false);
    if (searchResults.isEmpty) {
      // Отобразить SnackBar, если список пуст
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Результаты поиска не найдены.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      for (var item in searchResults) {
        _searchResults.add(item['id']);
      }
      // Если результаты есть, обновляем видимость
      setState(() {
        for (var restaurant in restarauntData) {
          // Ищем, есть ли ресторан с таким же 'id' в searchResults
          var isMatchFound =
              searchResults.any((result) => result['id'] == restaurant['id']);

          // Если ресторан найден в результатах поиска, ставим isVisible в true, иначе — в false
          if (isMatchFound) {
            restaurant['isVisible'] = true;
          } else {
            restaurant['isVisible'] = false;
          }
        }
        _currentIndex = 1;
      });
    }
  }

  void _onCameraPositionChanged(CameraPosition cameraPosition,
      CameraUpdateReason reason, bool isAnimated) async {
    // Пример логики для обновления маркера
    // final placemarkMapObject = _mapObjects
    //     .firstWhere((el) => el.mapId == MapObjectId) as PlacemarkMapObject;

    // setState(() {
    //   _mapObjects[_mapObjects.indexOf(placemarkMapObject)] =
    //       placemarkMapObject.copyWith(
    //     point: cameraPosition.target,
    //   );
    // });
  }

  void _updateMarkerIcon(
      String markerId, String imagePath, double scale) async {
    // Находим индекс маркера по ID
    final index = _mapObjects.indexWhere(
      (marker) => marker.mapId.value == markerId,
    );

    if (index != -1) {
      // Приводим маркер к типу PlacemarkMapObject, чтобы получить доступ к свойству point
      final originalMarker = _mapObjects[index] as PlacemarkMapObject;

      // Создаём новую иконку
      final updatedIconStyle = PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(imagePath),
          scale: scale,
        ),
      );

      // Создаём новый маркер с обновлённой иконкой
      final updatedMarker = PlacemarkMapObject(
        mapId: originalMarker.mapId,
        point: originalMarker.point,
        opacity: originalMarker.opacity,
        onTap: originalMarker.onTap,
        icon: updatedIconStyle,
      );

      // Обновляем список маркеров
      setState(() {
        _mapObjects[index] = updatedMarker;
        _activeMarkerId = markerId;
      });
    }
  }

  void _onPlacemarkTap(PlacemarkMapObject self, Point point) async {
    setState(() {
      // Проверяем, является ли текущий маркер активным
      if (_activeMarkerId == self.mapId.value) {
        _updateMarkerIcon(_activeMarkerId!, 'assets/icons/location.png', 0.2);
        _activeMarkerId = "";
        floatRest = {};
      } else {
        if (_activeMarkerId != null) {
          _updateMarkerIcon(_activeMarkerId!, 'assets/icons/location.png', 0.2);
        }
        _activeMarkerId = self.mapId.value;
        _updateMarkerIcon(
            _activeMarkerId!, 'assets/icons/orange_location.png', 0.4);

        var restaurant = restarauntData.firstWhere(
          (restaurant) => restaurant['id'] == _activeMarkerId,
          orElse: () => {},
        );

        if (restaurant != {}) {
          floatRest = {
            'id': restaurant['id'],
            'name': restaurant['name'],
            'avgReview': restaurant['avgReview'],
            'avgPrice': restaurant['avgPrice'],
            'latitude': restaurant['latitude'],
            'longitude': restaurant['longitude'],
            'imageUrl': restaurant['imageUrl'],
            'cntReviews': restaurant['cntReviews'],
            'deliveryInfo': restaurant['deliveryInfo'],
            'startTime': restaurant['startTime'],
            'endTime': restaurant['endTime'],
            'features': restaurant['features'],
            'restrictions': restaurant['restrictions'],
            'videoUrl': restaurant['videoUrl'],
            'restarauntType': restaurant['restarauntType'],
            'isToogle': restaurant['isToogle'],
            'siteUrl': restaurant['siteUrl'],
            'instaUrl': restaurant['instaUrl']
          };
        } else {
          floatRest = {};
        }
      }
    });

    if (_currentLocation != null) {
      final travelTime = await _getTravelTime(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
        point.latitude,
        point.longitude,
      );

      setState(() {
        floatRest['travelTime'] = travelTime; // Сохранение времени в пути
      });
    }

    print('Tapped placemark with ID: ${self.mapId}');
    print(
        'Coordinates of tapped placemark: ${self.point.latitude}, ${self.point.longitude}');
    print('Tapped at point: ${point.latitude}, ${point.longitude}');
  }

  Future<void> _addRestaurantMarker(double latitude, double longitude,
      String name, String rating, String price, String id) async {
    PlacemarkMapObject mapObject = PlacemarkMapObject(
      mapId: MapObjectId(id),
      point: Point(latitude: latitude, longitude: longitude),
      opacity: 1,
      onTap: (PlacemarkMapObject self, Point point) {
        _onPlacemarkTap(self, point);
      },
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage('assets/icons/location.png'),
        scale: 0.2,
      )),
    );

    setState(() {
      _mapObjects.add(mapObject);
    });
  }

  void _onMapTap(Point point) {
    // print('Координаты нажатия: ${point.latitude}, ${point.longitude}');

    // if (_activeMarkerId != '') {
    //   // Деактивируем активный маркер, сбрасывая его иконку
    //   _updateMarkerIcon(_activeMarkerId!, 'assets/icons/location.png', 0.2);

    //   // Очищаем идентификатор активного маркера
    //   setState(() {
    //     _activeMarkerId = null;
    //   });
    // }
  }

  void _moveToCurrentLocation() {
    if (_currentLocation != null) {
      _controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: _currentLocation!.latitude!,
              longitude: _currentLocation!.longitude!,
            ),
            zoom: 70,
          ),
        ),
      );
    } else {
      print('Не удалось получить текущее местоположение');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MapAppBar(
        showStock: _showStock,
        showBest: _showBest,
        showFilter: _showFilter,
        onButtonPressed: () => {
          _showAll(needState: true),
          // if (_currentIndex == 1) {_currentIndex = 0} else {_currentIndex = 1}
        },
        currentIndex: _currentIndex,
        searchCallback: _updateSearchResults,
      ),
      body: RepaintBoundary(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              IndexedStack(
                index: _currentIndex,
                children: [
                  // Экран с картой YandexMap
                  YandexMap(
                    onCameraPositionChanged: _onCameraPositionChanged,
                    logoAlignment: MapAlignment(
                      horizontal: HorizontalAlignment.left,
                      vertical: VerticalAlignment.top,
                    ),
                    onMapCreated: (YandexMapController controller) {
                      _controller = controller;
                      _controller.moveCamera(
                        CameraUpdate.newCameraPosition(
                          const CameraPosition(
                            target: Point(latitude: 53.9, longitude: 27.5667),
                            zoom: 13,
                          ),
                        ),
                      );
                    },
                    onMapTap: _onMapTap,
                    mapObjects: _mapObjects,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 60),
                    child: restarauntData.isEmpty ||
                            restarauntData
                                .every((item) => item['isVisible'] == false)
                        ? Center(
                            child: Text(
                            'Нет доступных ресторанов',
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ))
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                            itemCount: restarauntData.length,
                            itemBuilder: (context, index) {
                              final item = restarauntData[index];

                              // Проверка на null для каждого необходимого поля
                              if (item['imageUrl'] == null ||
                                  item['name'] == null ||
                                  item['restarauntType'] == null ||
                                  item['avgReview'] == null ||
                                  item['cntReviews'] == null ||
                                  item['avgPrice'] == null ||
                                  item['id'] == null ||
                                  item['isToogle'] is String ||
                                  !item['isVisible'] ||
                                  (_searchResults.isNotEmpty &&
                                      !_searchResults.contains(item['id']))) {
                                return SizedBox
                                    .shrink(); // Пропустить элемент, если любое из значений null
                              }

                              // Если все значения не null, создаем ListMapItem
                              return Column(
                                children: [
                                  ListMapItem(
                                    imageUrl: item['imageUrl'],
                                    name: item['name'],
                                    restarauntType: item['restarauntType'],
                                    avgReview: item['avgReview'].toDouble(),
                                    cntReviews: item['cntReviews'],
                                    timeByWalk: 5,
                                    avgPrice: item['avgPrice'],
                                    isToogle: item['isToogle'] ?? false,
                                    endTime: item['endTime'],
                                    documentId: item['id'],
                                    videoUrl: item['videoUrl'],
                                    instaUrl: item['instaUrl'],
                                    siteUrl: item['siteUrl'],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Divider(
                                    height: 1.0,
                                    indent: 16,
                                    endIndent: 16,
                                    color: Color.fromARGB(255, 210, 210, 210),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ), // маленький divider
                                ],
                              );
                            },
                          ),
                  )
                ],
              ),
              _currentIndex == 0
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0,
                            MediaQuery.of(context).size.height * 0.21, 16, 0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: _moveToCurrentLocation,
                          child: const FaIcon(FontAwesomeIcons.locationArrow,
                              color: Color.fromARGB(255, 243, 175, 78)),
                        ),
                      ),
                    )
                  : SizedBox(),
              (_activeMarkerId != "" && _currentIndex != 1)
                  ? Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          bottom: _activeMarkerId != "" && _currentIndex != 1
                              ? 65
                              : -200, // Смещение за пределы экрана
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () => {
                                showRestBottomSheet(
                                  context,
                                  restId: floatRest['id'],
                                  name: floatRest['name'],
                                  imageUrl: floatRest['imageUrl'],
                                  restarauntType: floatRest['restarauntType'],
                                  timeByWalk: 5,
                                  endTime: floatRest['endTime'],
                                  avgPrice: floatRest['avgPrice'],
                                  avgReview: floatRest['avgReview'],
                                  cntReviews: floatRest['cntReviews'],
                                  isToogle: floatRest['isToogle'],
                                  videoUrl: floatRest['videoUrl'],
                                  siteUrl: floatRest['siteUrl'],
                                  instaUrl: floatRest['instaUrl'],
                                )
                              },
                              child: Container(
                                width: 313,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color.fromARGB(255, 244, 160, 15),
                                      width: 5,
                                    ),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          floatRest['imageUrl'],
                                          width: 120,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      9, 8, 0, 0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    child: Text(
                                                      floatRest['name']
                                                          .toString()
                                                          .trim(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Color.fromARGB(
                                                            255, 48, 48, 48),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    floatRest['avgReview']
                                                        .toString()
                                                        .trim(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Color.fromARGB(
                                                          255, 48, 48, 48),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          11, 0, 0, 0),
                                                  child: Container(
                                                    width: 120,
                                                    height: 30,
                                                    child: Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      floatRest[
                                                              'restarauntType']
                                                          .toString()
                                                          .trim(),
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Color.fromARGB(
                                                            255, 114, 114, 114),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 0, 0, 7),
                                                  child: Text(
                                                    "(${floatRest['cntReviews'].toString()})"
                                                        .trim(),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Color.fromARGB(
                                                          255, 114, 114, 114),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 15, 0, 0),
                                              child: Row(
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.car,
                                                    size: 14,
                                                    color: Color.fromARGB(
                                                        255, 193, 193, 193),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    floatRest['travelTime'] ??
                                                        "5 мин",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              193,
                                                              193,
                                                              193),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    "${floatRest['avgPrice']} Br",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              193,
                                                              193,
                                                              193),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex =
                            (_currentIndex + 1) % 2; // переключение между 0 и 1
                      });
                    },
                    child: Container(
                      width: 328,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 160, 15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 19,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _currentIndex == 0 ? "Список" : "Карта",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapAppBar extends StatefulWidget implements PreferredSizeWidget {
  final onButtonPressed;
  final showStock;
  final showBest;
  final showFilter;
  final int currentIndex;
  final Function(List<Map<String, dynamic>>) searchCallback;

  const MapAppBar({
    super.key,
    required this.onButtonPressed,
    required this.currentIndex,
    required this.searchCallback,
    this.showStock,
    this.showBest,
    this.showFilter,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2.11);

  @override
  _MapAppBarState createState() => _MapAppBarState();
}

class _MapAppBarState extends State<MapAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 45, 16, 0),
            child: Row(
              children: [
                SearchMapBar(
                  onSearchResultsUpdated: widget.searchCallback,
                ),
                Spacer(),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.share_outlined),
                  color: const Color.fromARGB(255, 175, 175, 175),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 0, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(context, widget.showFilter, false);
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 175, 79),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/filter.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => {widget.showStock()}, // Обработчик нажатия
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      borderRadius:
                          BorderRadius.circular(10), // Радиус скругления
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/discount.svg',
                            color: Color.fromARGB(255, 48, 48, 48),
                            // size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Акции",
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => {widget.showBest()}, // Обработчик нажатия
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      borderRadius:
                          BorderRadius.circular(10), // Радиус скругления
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.star,
                            color: Color.fromARGB(255, 48, 48, 48),
                            size: 16,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Лучшие",
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => {}, // Обработчик нажатия
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      borderRadius:
                          BorderRadius.circular(10), // Радиус скругления
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/kitchen.svg',
                              color: Color.fromARGB(255, 48, 48, 48)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Кухня",
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
