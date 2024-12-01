import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingWidget extends StatefulWidget {
  const BookingWidget({super.key});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  String name = '';
  String address = '';
  DateTime datetime = DateTime.now();
  String place = '';
  String imgUrl = '';
  String time = "";
  bool hasBooking = false; // Флаг для отслеживания наличия бронирования

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  Future<void> fetchBookingData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid; // Получаем userId текущего пользователя

      // Получаем все бронирования для текущего пользователя
      QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      if (bookingsSnapshot.docs.isNotEmpty) {
        for (var doc in bookingsSnapshot.docs) {
          var bookingData = doc.data() as Map<String, dynamic>;

          String restId = bookingData['restId'];

          // Преобразуем строку в DateTime, если selectedDate хранится как строка
          String selectedDateStr =
              bookingData['selectedDate']; // Формат "yyyy-MM-dd HH:mm:ss"
          DateTime selectedDate =
              DateTime.parse(selectedDateStr); // Преобразуем строку в DateTime
          String selectedTime = bookingData[
              'selectedTime']; // Ожидаем строку времени, например "18:00"

          // Получаем текущую дату и время
          DateTime now = DateTime.now();

          // Проверяем каждый параметр отдельно
          bool isDateInPast = selectedDate.year < now.year ||
              (selectedDate.year == now.year &&
                  selectedDate.month < now.month) ||
              (selectedDate.year == now.year &&
                  selectedDate.month == now.month &&
                  selectedDate.day < now.day);

          if (!isDateInPast) {
            // Если дата не в прошлом, проверяем время
            List<String> selectedTimeParts = selectedTime
                .split(':'); // Разбиваем строку времени "18:00" на ["18", "00"]
            int selectedHour =
                int.parse(selectedTimeParts[0]); // Часы из времени
            int selectedMinute =
                int.parse(selectedTimeParts[1]); // Минуты из времени

            bool isTimeInPast = selectedDate.year == now.year &&
                selectedDate.month == now.month &&
                selectedDate.day == now.day &&
                (selectedHour < now.hour ||
                    (selectedHour == now.hour && selectedMinute < now.minute));

            // Если время в прошлом, то пропускаем это бронирование
            if (isTimeInPast) {
              continue;
            }
          } else {
            // Если дата в прошлом, пропускаем это бронирование
            continue;
          }

          // Если дата и время валидные, обрабатываем данные
          List<bool> selectedPlace =
              List<bool>.from(bookingData['selectedPlace']);

          // Определяем место по выбранным параметрам
          place = selectedPlace[0]
              ? 'Терасса'
              : selectedPlace[1]
                  ? 'У окна'
                  : 'У бара';

          // Получаем данные о ресторане
          DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
              .collection('restaraunts')
              .doc(restId)
              .get();

          if (restaurantSnapshot.exists) {
            var restaurantData =
                restaurantSnapshot.data() as Map<String, dynamic>;
            name = restaurantData['name'];
            address = restaurantData['address'];

            // Получаем URL картинки из Firebase Storage
            String imageUrl = restaurantData['imageUrl'];
            Reference storageRef =
                FirebaseStorage.instance.ref().child(imageUrl);
            String downloadUrl = await storageRef.getDownloadURL();

            setState(() {
              imgUrl = downloadUrl;
              datetime = selectedDate;
              time = selectedTime;
              hasBooking = true; // Устанавливаем флаг, что бронирование найдено
            });

            // Выходим из цикла, так как нашли первое подходящее бронирование
            return;
          }
        }

        // Если ни одно бронирование не подошло
        setState(() {
          hasBooking = false;
        });
      } else {
        // Если бронирования отсутствуют
        setState(() {
          hasBooking = false;
        });
      }
    } else {
      // Пользователь не авторизован
      print("User not logged in");
    }
  }

  Map formatDateTime(DateTime dateTime) {
    const List<String> months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];

    const List<String> weekdays = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];

    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1];
    String weekDay = weekdays[dateTime.weekday - 1];
    String time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return {
      'day': day,
      'month': month,
      'weekDay': weekDay,
      'time': time,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map formatedDateMap = formatDateTime(datetime);

    return hasBooking
        ? Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 114, 114, 114),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Divider(
                    height: 1,
                    color: Color.fromARGB(255, 235, 235, 235),
                    indent: 15,
                    endIndent: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 12, 0, 0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imgUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  color: Color.fromARGB(255, 243, 175, 79),
                                  size: 22),
                              const SizedBox(width: 7),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromARGB(
                                        255, 138, 138, 142),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  color: Color.fromARGB(255, 243, 175, 79),
                                  size: 20),
                              const SizedBox(width: 7),
                              Text(
                                '${formatedDateMap['day']} ${formatedDateMap['month']}, ${formatedDateMap['weekDay']}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 142),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: Color.fromARGB(255, 243, 175, 79),
                                  size: 20),
                              const SizedBox(width: 7),
                              Text(
                                time,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 142),
                                ),
                              ),
                              const SizedBox(width: 7),
                              const Icon(Icons.table_restaurant,
                                  color: Color.fromARGB(255, 243, 175, 79)),
                              const SizedBox(width: 7),
                              Text(
                                place,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 142),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                  child: ElevatedButton(
                    onPressed: () => {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 244, 160, 15)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))))),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Построить маршрут",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Text(
              "У вас нет бронирований",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
          );
  }
}
