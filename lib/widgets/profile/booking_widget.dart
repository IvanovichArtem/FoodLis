import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingWidget extends StatefulWidget {
  final String name;
  final String address;
  final DateTime datetime;
  final String place;
  final String imgUrl;

  const BookingWidget(
      {Key? key,
      required this.name,
      required this.address,
      required this.datetime,
      required this.place,
      required this.imgUrl})
      : super(key: key);

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
    String time = dateTime.hour.toString().padLeft(2, '0') +
        ':' +
        dateTime.minute.toString().padLeft(2, '0');

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          // Адрес и share
          Padding(
            padding: EdgeInsets.fromLTRB(17, 15, 18, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 138, 138, 142),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.share_outlined,
                  color: Color.fromARGB(255, 138, 138, 142),
                  size: 18,
                ),
              ],
            ),
          ),
          // Разделитель
          Padding(
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
            padding: EdgeInsets.fromLTRB(17, 12, 0, 0),
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //адрес
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 22,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            widget.address,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 138, 138, 142),
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //дата
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 20,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          formatedDateMap['day'] +
                              " " +
                              formatedDateMap['month'] +
                              ", " +
                              formatedDateMap['weekDay'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 138, 138, 142),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //время и место
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 243, 175, 79),
                          size: 20,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          formatedDateMap['time'],
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 138, 138, 142),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.table_restaurant,
                          color: Color.fromARGB(255, 243, 175, 79),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.place,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 138, 138, 142),
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
            padding: EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 243, 175, 79)),
                child: Container(
                  width: double.infinity, // Займет всю доступную ширину
                  child: Text(
                    "Построить маршрут",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
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
