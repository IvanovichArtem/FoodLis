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
    backgroundColor: Colors.transparent,
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
  final GlobalKey<RestarauntTypeWidgetState> restaurantTypeKey =
      GlobalKey<RestarauntTypeWidgetState>();
  final GlobalKey<DistanceWidgetState> distanceKey =
      GlobalKey<DistanceWidgetState>();
  final GlobalKey<DeliveryInfoState> deliveryKey =
      GlobalKey<DeliveryInfoState>();
  final GlobalKey<AvailableSeatsInfoState> availableSeatsKey =
      GlobalKey<AvailableSeatsInfoState>();
  final GlobalKey<DinnerInfoState> dinnerKey = GlobalKey<DinnerInfoState>();

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

    // Reset each widget via its key
    receiptKey.currentState?.reset(receiptStartValue, receiptEndValue);
    kitchensKey.currentState?.reset();
    restaurantTypeKey.currentState?.reset();
    distanceKey.currentState?.reset();
    deliveryKey.currentState?.reset();
    availableSeatsKey.currentState?.reset();
    dinnerKey.currentState?.reset();
  }

  void filter() {
    // Получаем состояние всех виджетов в одном Map
    Map<String, dynamic> currentState = {
      'Receipt Widget State': receiptKey.currentState?.getCurrentState(),
      'Kitchens Filter State': kitchensKey.currentState?.getCurrentState(),
      'Restaurant Type State':
          restaurantTypeKey.currentState?.getCurrentState(),
      'Distance Widget State': distanceKey.currentState?.getCurrentState(),
      'Delivery Info State': deliveryKey.currentState?.getCurrentState(),
      'Available Seats Info State':
          availableSeatsKey.currentState?.getCurrentState(),
      'Dinner Info State': dinnerKey.currentState?.getCurrentState(),
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
                    key: receiptKey,
                    startValue: receiptStartValue,
                    endValue: receiptEndValue,
                  ),
                  KitchensFilterWidget(key: kitchensKey),
                  RestarauntTypeWidget(
                    key: restaurantTypeKey,
                    buttonsData: [
                      {'name': 'Ресторан', 'isSelected': false},
                      {'name': 'Кафе', 'isSelected': false},
                      {'name': 'Бар', 'isSelected': false},
                      {'name': 'Караоке', 'isSelected': false},
                      {'name': 'Чайная', 'isSelected': false},
                      {'name': 'Пекарня', 'isSelected': false},
                      {'name': 'Кальян', 'isSelected': false},
                      {'name': 'Бабл ти', 'isSelected': false},
                    ],
                  ),
                  DistanceWidget(key: distanceKey),
                  DeliveryInfo(
                    key: deliveryKey,
                    isYandexSelected: isYandexSelected,
                    isDeliverySelected: isDeliverySelected,
                    isRestaurantSelected: isRestaurantSelected,
                  ),
                  AvailableSeatsInfo(
                    key: availableSeatsKey,
                    isTodaySelected: isTodaySelected,
                    isTomorrowSelected: isTomorrowSelected,
                  ),
                  DinnerInfo(key: dinnerKey),
                  const SizedBox(height: 5),
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
