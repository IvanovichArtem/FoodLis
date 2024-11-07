import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_modal.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({super.key});

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  late YandexMapController _controller;
  LocationData? _currentLocation;
  final List<MapObject> _mapObjects = [];
  final double _zoomLevel = 15.0;

  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    // Проверка разрешений
    PermissionStatus permissionGranted = await location.requestPermission();

    if (permissionGranted == PermissionStatus.granted) {
      // Если разрешение предоставлено, получаем местоположение
      _currentLocation = await location.getLocation();
      _addCurrentLocationMarker();
      await _fetchRestaurants();
    } else {
      // Если пользователь отказался предоставить разрешение, показываем сообщение
      SnackBar(
          content: Text(
              "Доступ к местоположению ограничен. Разрешите доступ для получения данных о ресторанах рядом."));
      // Здесь можно добавить логику показа уведомления пользователю
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
        String rating = data['avgReview'].toString();
        String price = data['avgPrice'].toString();

        await _addRestaurantMarker(
            latitude, longitude, name, rating, price, doc.id);
      } catch (e) {
        print('Ошибка при обработке документа: $e');
        continue;
      }
    }
  }

  Future<Uint8List> createCustomMarker(
      String name, String rating, String price) async {
    // Увеличиваем размеры холста для иконки location_dot
    final double width = 300;
    final double height = 230; // Увеличенная высота

    // Создаем PictureRecorder для записи рисования на холсте
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas =
        Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(width, height)));

    // Задаем фон маркера
    final Paint paint = Paint()
      ..color = Colors.white
      ..isAntiAlias = true;
    final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 40, width, height - 50),
        Radius.circular(34)); // Сдвигаем фон вниз
    canvas.drawRRect(rrect, paint);

    // Настройки текста для имени
    final textPainterName = TextPainter(
      maxLines: 1,
      ellipsis: '...',
      text: TextSpan(
        text: name,
        style: TextStyle(
          color: Color.fromARGB(255, 244, 175, 17),
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainterName.layout(maxWidth: width - 36);
    textPainterName.paint(canvas, Offset(18, 61)); // Сдвигаем текст вниз

    // Рисуем иконку location_dot поверх всего
    final locationIcon = Icons.location_on;
    final locationIconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(locationIcon.codePoint),
        style: TextStyle(
          fontSize: 80, // Размер иконки location_dot
          fontFamily: locationIcon.fontFamily,
          color: Color.fromARGB(255, 244, 175, 17),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    locationIconPainter.layout();
    locationIconPainter.paint(
        canvas, Offset(width / 2.75, -10)); // Сдвигаем иконку выше

    // Рисуем иконку звезды
    final starIcon = Icons.star_rounded;
    final starIconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(starIcon.codePoint),
        style: TextStyle(
          fontSize: 54, // Размер иконки звезды
          fontFamily: starIcon.fontFamily,
          color: Color.fromARGB(255, 244, 175, 17),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    starIconPainter.layout();
    starIconPainter.paint(canvas, Offset(27, 116)); // Сдвигаем иконку ниже

    // Рисуем текст с рейтингом и ценой
    final textPainterRating = TextPainter(
      text: TextSpan(
        text: "$rating ~ $price Br",
        style: TextStyle(
          fontSize: 36, // Размер текста
          color: Color.fromARGB(255, 244, 175, 17),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainterRating.layout();
    textPainterRating.paint(canvas, Offset(90, 122)); // Сдвигаем текст ниже

    // Завершаем запись рисования и создаем изображение
    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  void _onPlacemarkTap(PlacemarkMapObject self, Point point) async {
    // Выводим информацию о маркере и точке нажатия
    print('Tapped placemark with ID: ${self.mapId}');
    print(
        'Coordinates of tapped placemark: ${self.point.latitude}, ${self.point.longitude}');
    print('Tapped at point: ${point.latitude}, ${point.longitude}');

    // Получаем данные из Firestore
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('restaraunts') // замените на название вашей коллекции
          .doc(self.mapId.value) // используем mapId для получения документа
          .get();

      if (document.exists) {
        // Получаем данные
        var data = document.data() as Map<String, dynamic>;

        String name =
            data['name']; // Предполагаем, что в документе есть поле 'name'
        String imagePath = data['imageUrl'];

        String imageUrl =
            await FirebaseStorage.instance.ref(imagePath).getDownloadURL();

        // Показываем детали ресторана
        _showRestaurantDetails(self.mapId.value, name, imageUrl);
      } else {
        print('No restaurant found for the given ID.');
      }
    } catch (e) {
      print('Error fetching restaurant details: $e');
    }
  }

  void _showRestaurantDetails(String restId, String name, String imageUrl) {
    showRestBottomSheet(
      context,
      restId: restId,
      name: name,
      imageUrl: imageUrl,
    );
  }

  Future<void> _addRestaurantMarker(double latitude, double longitude,
      String name, String rating, String price, String id) async {
    // Создаем высококачественный маркер
    Uint8List markerBytes = await createCustomMarker(name, rating, price);

    // Добавляем маркер с масштабированием
    final mapObject = PlacemarkMapObject(
      mapId: MapObjectId(id),
      point: Point(latitude: latitude, longitude: longitude),
      opacity: 1,
      onTap: (PlacemarkMapObject self, Point point) {
        _onPlacemarkTap(self, point);
      },
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(markerBytes),
          scale:
              1, // Уменьшите масштаб, чтобы маркер выглядел адекватного размера на карте
          zIndex: 1,
        ),
      ),
    );

    setState(() {
      _mapObjects.add(mapObject);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _widgetKey,
      child: Scaffold(
        body: Stack(
          children: [
            YandexMap(
              logoAlignment: MapAlignment(
                horizontal: HorizontalAlignment.left,
                vertical: VerticalAlignment.bottom,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 113),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _moveToCurrentLocation,
                  child: const FaIcon(FontAwesomeIcons.locationArrow,
                      color: Color.fromARGB(255, 243, 175, 78)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  void _onMapTap(Point point) {
    print('Координаты нажатия: ${point.latitude}, ${point.longitude}');
  }
}
