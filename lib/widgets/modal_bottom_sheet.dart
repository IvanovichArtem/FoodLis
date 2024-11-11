import 'package:flutter/material.dart';
import 'package:food_lis/widgets/bottom_sheet/receipt.dart';
import 'package:food_lis/widgets/bottom_sheet/kitchens.dart';
import 'package:food_lis/widgets/bottom_sheet/restaraunt_type.dart';
import 'package:food_lis/widgets/bottom_sheet/distance.dart';
import 'package:food_lis/widgets/bottom_sheet/delivery_info.dart';
import 'package:food_lis/widgets/bottom_sheet/available_seats.dart';
import 'package:food_lis/widgets/bottom_sheet/dinner.dart';
import 'package:google_fonts/google_fonts.dart';

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
  // final GlobalKey<ReceiptWidgetState> receiptKey =
  //     GlobalKey<ReceiptWidgetState>();
  // final GlobalKey<KitchensFilterWidgetState> kitchensKey =
  //     GlobalKey<KitchensFilterWidgetState>();
  // final GlobalKey<MultipleToogleWidgetState> restaurantTypeKey =
  //     GlobalKey<MultipleToogleWidgetState>();
  // final GlobalKey<DistanceWidgetState> distanceKey =
  //     GlobalKey<DistanceWidgetState>();
  // final GlobalKey<DeliveryInfoState> deliveryKey =
  //     GlobalKey<DeliveryInfoState>();
  // final GlobalKey<AvailableSeatsInfoState> availableSeatsKey =
  //     GlobalKey<AvailableSeatsInfoState>();
  // final GlobalKey<DinnerInfoState> dinnerKey = GlobalKey<DinnerInfoState>();

  double receiptStartValue = 10.0;
  double receiptEndValue = 20.0;
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
      receiptEndValue = 20.0;
      isYandexSelected = false;
      isDeliverySelected = false;
      isRestaurantSelected = false;
      isTodaySelected = false;
      isTomorrowSelected = false;
    });

    // // Reset each widget via its key
    // receiptKey.currentState?.reset(receiptStartValue, receiptEndValue);
    // kitchensKey.currentState?.reset();
    // restaurantTypeKey.currentState?.reset();
    // distanceKey.currentState?.reset();
    // deliveryKey.currentState?.reset();
    // availableSeatsKey.currentState?.reset();
    // dinnerKey.currentState?.reset();
  }

  void filter() {
    // Получаем состояние всех виджетов в одном Map
    Map<String, dynamic> currentState = {
      // 'Receipt Widget State': receiptKey.currentState?.getCurrentState(),
      // 'Kitchens Filter State': kitchensKey.currentState?.getCurrentState(),
      // 'Restaurant Type State':
      //     restaurantTypeKey.currentState?.getCurrentState(),
      // 'Distance Widget State': distanceKey.currentState?.getCurrentState(),
      // 'Delivery Info State': deliveryKey.currentState?.getCurrentState(),
      // 'Available Seats Info State':
      //     availableSeatsKey.currentState?.getCurrentState(),
      // 'Dinner Info State': dinnerKey.currentState?.getCurrentState(),
    };

    // Выводим все данные в консоль
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
                    // key: receiptKey,
                    startValue: receiptStartValue,
                    endValue: receiptEndValue,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  KitchensFilterWidget(
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
                    // key: restaurantTypeKey,
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
                  MultipleToogleWidget(
                    // key: restaurantTypeKey,
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
                  DistanceWidget(
                      // key: distanceKey
                      ),
                  SizedBox(
                    height: 14,
                  ),
                  KitchensFilterWidget(
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
                    // key: restaurantTypeKey,
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
                  MultipleToogleWidget(
                    // key: restaurantTypeKey,
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
