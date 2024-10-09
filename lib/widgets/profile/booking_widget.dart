import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/profile/popup_menu.dart';

class BookingWidget extends StatefulWidget {
  final String name;
  final String address;
  final DateTime datetime;
  final String place;
  final String imgUrl;

  const BookingWidget(
      {super.key,
      required this.name,
      required this.address,
      required this.datetime,
      required this.place,
      required this.imgUrl});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  Map formatDateTime(DateTime dateTime) {
    // Массивы для дней и месяцев на русском
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

    // Получаем компоненты даты
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
    Map formatedDateMap = formatDateTime(widget.datetime);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          // Адрес и share
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 15, 18, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 138, 138, 142),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const IconPopupMenu(
                  menuItems: [
                    "Подробнее",
                    "Поделиться записью",
                    "Отменить бронь"
                  ],
                )
              ],
            ),
          ),
          // Разделитель
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Divider(
              height: 1,
              color: Color.fromARGB(255, 235, 235, 235),
              indent: 15,
              endIndent: 15,
            ),
          ),
          // Информация
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 12, 0, 0),
            child: Row(
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.imgUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //адрес
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 22,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            widget.address,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 138, 138, 142),
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //дата
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          formatedDateMap['day'] +
                              " " +
                              formatedDateMap['month'] +
                              ", " +
                              formatedDateMap['weekDay'],
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 138, 138, 142),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //время и место
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          formatedDateMap['time'],
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 138, 138, 142),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Icon(
                          Icons.table_restaurant,
                          color: Color.fromARGB(255, 243, 175, 79),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.place,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 138, 138, 142),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // Кнопка
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 175, 79)),
                child: SizedBox(
                  width: double.infinity, // Займет всю доступную ширину
                  child: Text(
                    "Построить маршрут",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
