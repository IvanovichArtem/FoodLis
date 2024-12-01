import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:food_lis/widgets/bottom_sheet/custom_toogle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Booking extends StatefulWidget {
  final String restId;
  const Booking({super.key, required this.restId});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? selectedTime;
  int selectedGuests = 1;
  String? selectedPlace;
  ScrollController _scrollController = ScrollController();
  List<bool> _selectedItems = [false, false, false];
  ValueNotifier<bool> isSelectedBirthday = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    // Прокручиваем к центральной дате после инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double offset =
          14 * 21; // 56.0 — это ширина каждого элемента (можно настроить)
      _scrollController.jumpTo(offset);
    });
  }

  void booking(BuildContext context, String restId) async {
    // Получаем текущего пользователя из FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Проверяем, если пользователь не найден
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Пожалуйста, войдите в систему!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String userId = user.uid; // Получаем userId (UID пользователя)

    // Проверяем на null
    if (selectedDate == null ||
        selectedTime == null ||
        selectedGuests == null ||
        _selectedItems == null ||
        isSelectedBirthday == null) {
      // Если какой-то параметр null, выводим SnackBar с ошибкой
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Все параметры должны быть заполнены!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Проверяем значение selectedGuests на диапазон от 1 до 7
    if (selectedGuests < 1 || selectedGuests > 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Количество гостей должно быть от 1 до 7!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Подготовка данных для записи в Firebase
    Map<String, dynamic> bookingData = {
      'restId': restId,
      'userId': userId,
      'selectedDate':
          selectedDate.toIso8601String(), // Преобразуем дату в строку
      'selectedTime': selectedTime, // Здесь теперь просто строка
      'selectedGuests': selectedGuests,
      'isSelectedBirthday': isSelectedBirthday.value,
      'selectedPlace': _selectedItems, // Массив с тремя bool значениями
    };

    try {
      // Пытаемся записать данные в Firestore
      await FirebaseFirestore.instance.collection('bookings').add(bookingData);

      // Если все окей, показываем новый виджет успеха
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: SuccessWidget(), // Новый виджет для успешного бронирования
        ),
      );
    } catch (e) {
      // Если произошла ошибка при записи в Firebase
      print('Error: $e');
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: ErrorWidget(), // Новый виджет для ошибки при бронировании
        ),
      );
    }
  }

  Widget _buildImageCard(String imageUrl, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItems[index] =
              !_selectedItems[index]; // Меняем состояние при нажатии
        });
      },
      child: Container(
        width: 100, // Уменьшаем ширину для сокращения расстояния по бокам
        height: 160,
        margin:
            const EdgeInsets.symmetric(horizontal: 4), // Симметричные отступы
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedScale(
              scale: _selectedItems[index]
                  ? 1.1
                  : 1.0, // Анимация изменения масштаба
              duration: const Duration(milliseconds: 200), // Плавность
              child: Container(
                width: 100,
                height: 130,
                padding: const EdgeInsets.all(4), // Отступ для обводки
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedItems[index]
                        ? Colors.orange
                        : Colors.transparent, // Обводка только на картинке
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(15), // Обводка с закруглением
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15), // Закругление только для изображения
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4), // Отступ между изображением и текстом
            Text(
              label, // Подпись, которую вы сами сможете заменить
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 114, 114, 114),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Бронирование',
          style: GoogleFonts.montserrat(
              color: Color.fromARGB(255, 48, 48, 48),
              fontSize: 26,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок "Дата"
              Text('Дата',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 48, 48))),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                height: 2,
              ),
              SizedBox(
                height: 15,
              ),
              // Календарь с выбором даты
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(15, (index) {
                    DateTime date = selectedDate.add(Duration(days: index - 7));
                    Intl.defaultLocale = 'ru_RU';

                    String weekdayName = DateFormat('EE').format(date);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date; // Обновляем выбранную дату
                        });
                      },
                      child: Container(
                        key: ValueKey<DateTime>(
                            date), // Уникальный ключ для каждого элемента
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedDate.day == date.day
                              ? Colors.orange
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                color: selectedDate.day == date.day
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              weekdayName,
                              style: TextStyle(
                                color: selectedDate.day == date.day
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Время',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 48, 48))),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: List.generate(10, (index) {
                  final timeSlots = [
                    '9:00',
                    '10:00',
                    '11:00',
                    '12:00',
                    '13:00',
                    '14:00',
                    '15:00',
                    '16:00',
                    '17:00',
                    '18:00'
                  ];
                  return ChoiceChip(
                    showCheckmark: false,
                    backgroundColor: selectedTime == timeSlots[index]
                        ? Colors.orange
                        : Colors.white,
                    labelStyle: GoogleFonts.montserrat(
                      color: selectedTime == timeSlots[index]
                          ? Colors.white
                          : Colors.orange,
                    ),
                    label: Text(timeSlots[index]),
                    selected: selectedTime == timeSlots[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedTime = selected ? timeSlots[index] : null;
                      });
                    },
                    selectedColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: selectedTime == timeSlots[index]
                            ? Colors.orange
                            : Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Гости',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 48, 48))),
              SizedBox(height: 10),
              Wrap(
                spacing: 0,
                children: List.generate(7, (index) {
                  final guestSlots = [
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                  ];
                  return ChoiceChip(
                    showCheckmark: false,
                    backgroundColor: selectedGuests == guestSlots[index]
                        ? Colors.orange // Выбранный элемент — оранжевый фон
                        : Colors.white, // Не выбранный элемент — белый фон
                    labelStyle: GoogleFonts.montserrat(
                      color: selectedGuests == int.parse(guestSlots[index])
                          ? Colors.white // Текст выбранного элемента — белый
                          : Colors
                              .orange, // Текст невыбранного элемента — оранжевый
                    ),

                    label: Text(guestSlots[index]),
                    selected: selectedGuests == int.parse(guestSlots[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedGuests =
                            selected ? int.parse(guestSlots[index]) : 1;
                      });
                    },
                    selectedColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: selectedGuests == int.parse(guestSlots[index])
                            ? Colors.orange
                            : Colors.orange,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                child: Divider(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'У гостя день рождения',
                    style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 143, 143, 143),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomToggleSwitch(
                    isSelectedNotifier:
                        isSelectedBirthday, // временно используем ValueNotifier
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('Место',
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 48, 48, 48))),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImageCard(
                        'assets/images/booking/терасса.jpg', 'Терасса', 0),
                    SizedBox(
                      width: 10,
                    ),
                    _buildImageCard(
                        'assets/images/booking/у окна.jpg', 'У окна', 1),
                    SizedBox(
                      width: 10,
                    ),
                    _buildImageCard(
                        'assets/images/booking/у бара.jpg', 'У бара', 2),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange)),
                      onPressed: () => booking(
                            context,
                            widget.restId,
                          ),
                      child: Text(
                        "Забронировать",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Виджет для успешного бронирования
class SuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.white, size: 50),
          SizedBox(height: 20),
          Text(
            'Бронирование успешно!',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

// Виджет для ошибки при бронировании
class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.white, size: 50),
          SizedBox(height: 20),
          Text(
            'Ошибка при бронировании!',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
