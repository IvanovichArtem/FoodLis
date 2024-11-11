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

class MapScreen extends StatefulWidget {
  final int initialIndex;
  final List<Map<String, dynamic>> data;

  const MapScreen({super.key, required this.initialIndex, required this.data});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> restaurantData = [];
  late YandexMapController _controller;
  LocationData? _currentLocation;
  List<MapObject> _mapObjects = [];
  final double _currentZoom = 18.0; // Стартовый уровень масштаба

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchRestaurants();
    _currentIndex = widget.initialIndex;
  }

  void _onButtonPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
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

        String imageUrl =
            await FirebaseStorage.instance.ref(imageUrlPath).getDownloadURL();

        restaurantData.add({
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
          'restarauntType': restarauntType
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

  void _onPlacemarkTap(PlacemarkMapObject self, Point point) async {
    // Выводим информацию о маркере и точке нажатия
    print('Tapped placemark with ID: ${self.mapId}');
    print(
        'Coordinates of tapped placemark: ${self.point.latitude}, ${self.point.longitude}');
    print('Tapped at point: ${point.latitude}, ${point.longitude}');

    // int index = _mapObjects.indexWhere((obj) => obj.mapId == self.mapId);

    // PlacemarkMapObject updatedPlacemark = PlacemarkMapObject(
    //     mapId: self.mapId,
    //     point: self.point,
    //     opacity: 1,
    //     icon: PlacemarkIcon.single(PlacemarkIconStyle(
    //       image: BitmapDescriptor.fromAssetImage(
    //           'assets/icons/orange_location.png'),
    //       scale: 0.4,
    //     )));
    // if (index != -1) {
    //   setState(() {
    //     _mapObjects[index] = updatedPlacemark;
    //   });
    // }

    // Получаем данные из Firestore
    // try {
    //   DocumentSnapshot document = await FirebaseFirestore.instance
    //       .collection('restaraunts') // замените на название вашей коллекции
    //       .doc(self.mapId.value) // используем mapId для получения документа
    //       .get();

    //   if (document.exists) {
    //     // Получаем данные
    //     var data = document.data() as Map<String, dynamic>;

    //     String name =
    //         data['name']; // Предполагаем, что в документе есть поле 'name'
    //     String imagePath = data['imageUrl'];

    //     String imageUrl =
    //         await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

    //     // Показываем детали ресторана
    //     _showRestaurantDetails(self.mapId.value, name, imageUrl);
    //   } else {
    //     print('No restaurant found for the given ID.');
    //   }
    // } catch (e) {
    //   print('Error fetching restaurant details: $e');
    // }
  }

  // void _showRestaurantDetails(String restId, String name, String imageUrl) {
  //   showRestBottomSheet(
  //     context,
  //     restId: restId,
  //     name: name,
  //     imageUrl: imageUrl,
  //   );
  // }

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
    print('Координаты нажатия: ${point.latitude}, ${point.longitude}');
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
        onButtonPressed: _onButtonPressed,
        currentIndex: _currentIndex,
      ),
      body: RepaintBoundary(
        child: Scaffold(
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
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                    itemCount: restaurantData.length,
                    itemBuilder: (context, index) {
                      final item = restaurantData[index];

                      // Проверка на null для каждого необходимого поля
                      if (item['imageUrl'] == null ||
                          item['name'] == null ||
                          item['restarauntType'] == null ||
                          item['avgReview'] == null ||
                          item['cntReviews'] == null ||
                          item['avgPrice'] == null ||
                          item['id'] == null) {
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
                            avgReview: item['avgReview'],
                            cntReviews: item['cntReviews'],
                            timeByWalk: 5,
                            avgPrice: item['avgPrice'],
                            isToogle: false,
                            endTime: item['endTime'],
                            documentId: item['id'],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                              height: 1.0,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.grey),
                          SizedBox(
                            height: 5,
                          ) // маленький divider
                        ],
                      );
                    },
                  )
                ],
              ),
              _currentIndex == 0
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 160, 16, 0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: _moveToCurrentLocation,
                          child: const FaIcon(FontAwesomeIcons.locationArrow,
                              color: Color.fromARGB(255, 243, 175, 78)),
                        ),
                      ),
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
  final Function(int) onButtonPressed;
  final int currentIndex;

  const MapAppBar({
    Key? key,
    required this.onButtonPressed,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);

  @override
  _MapAppBarState createState() => _MapAppBarState();
}

class _MapAppBarState extends State<MapAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => {},
        color: const Color.fromARGB(255, 48, 48, 48),
      ),
      flexibleSpace: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(49, 45, 0, 0),
            child: Row(
              children: [
                SearchMapBar(
                  onSearchResultsUpdated: (p0) => {},
                ),
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
                    showCustomBottomSheet(context);
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
                          FaIcon(
                            FontAwesomeIcons.tag,
                            color: Color.fromARGB(255, 48, 48, 48),
                            size: 16,
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
                          FaIcon(
                            FontAwesomeIcons.utensils,
                            color: Color.fromARGB(255, 48, 48, 48),
                            size: 16,
                          ),
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
