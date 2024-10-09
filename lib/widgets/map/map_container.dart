import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart'; // Для получения текущего местоположения
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({super.key});

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  late YandexMapController _controller;
  LocationData? _currentLocation;
  final List<MapObject> _mapObjects = []; // Список маркеров на карте

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Получаем текущее местоположение при инициализации
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    await location.requestPermission();
    _currentLocation = await location.getLocation();
    // Добавляем маркер на текущее местоположение
    _addCurrentLocationMarker();
  }

  void _addCurrentLocationMarker() {
    if (_currentLocation != null) {
      final mapObject = PlacemarkMapObject(
        // Создаем маркер
        mapId: MapObjectId('current_location'), // Уникальный ID для маркера
        point: Point(
          latitude: _currentLocation!.latitude!,
          longitude: _currentLocation!.longitude!,
        ),
      );

      // setState(() {
      //   _mapObjects.add(mapObject); // Добавляем маркер в список
      // });
    }
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
            zoom: 15, // Установите желаемый уровень зума
          ),
        ),
      );
    } else {
      // Обработка случая, если местоположение не было получено
      print('Не удалось получить текущее местоположение');
    }
  }

  void _onMapTap(Point point) {
    // Обработка нажатия на карту
    print('Координаты нажатия: ${point.latitude}, ${point.longitude}');
    // Здесь вы можете добавить логику для получения информации о месте
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            logoAlignment: MapAlignment(
              horizontal: HorizontalAlignment.left,
              vertical: VerticalAlignment.bottom,
            ),
            onMapCreated: (YandexMapController controller) {
              _controller = controller;
              // Переместите камеру на начальную позицию (например, Минск)
              _controller.moveCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    target: Point(latitude: 53.9, longitude: 27.5667), // Минск
                    zoom: 13,
                  ),
                ),
              );
            },
            onMapTap: _onMapTap, // Устанавливаем обработчик нажатий на карту
            mapObjects: _mapObjects, // Передаем список маркеров на карту
          ),
          Align(
            alignment: Alignment
                .bottomRight, // Здесь настраиваем позицию FloatingActionButton
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 16, 113), // Отступ от края экрана
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: _moveToCurrentLocation,
                child: const FaIcon(FontAwesomeIcons.locationArrow,
                    color:
                        Color.fromARGB(255, 243, 175, 78)), // Иконка для кнопки
              ),
            ),
          ),
        ],
      ),
    );
  }
}
