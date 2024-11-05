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
  double receiptStartValue = 10.0;
  double receiptEndValue = 20.0;
  bool isYandexSelected = false;
  bool isDeliverySelected = false;
  bool isRestaurantSelected = true;
  bool isTodaySelected = false;
  bool isTomorrowSelected = false;

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
  }

  // void applyChanges() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Изменения применены!")),
  //   );
  // }

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
                    startValue: receiptStartValue,
                    endValue: receiptEndValue,
                  ),
                  KitchensFilterWidget(
                      // Provide necessary state or callbacks
                      ),
                  RestarauntTypeWidget(
                    buttonsData: [
                      {'name': 'Ресторан', 'isSelected': isRestaurantSelected},
                      {'name': 'Кафе', 'isSelected': false},
                      {'name': 'Бар', 'isSelected': false},
                      {'name': 'Караоке', 'isSelected': false},
                      {'name': 'Чайная', 'isSelected': false},
                      {'name': 'Пекарня', 'isSelected': false},
                      {'name': 'Кальян', 'isSelected': false},
                      {'name': 'Бабл ти', 'isSelected': false},
                    ],
                  ),
                  DistanceWidget(
                      // Provide necessary state or callbacks
                      ),
                  DeliveryInfo(
                    isYandexSelected: isYandexSelected,
                    isDeliverySelected: isDeliverySelected,
                    isRestaurantSelected: isRestaurantSelected,
                  ),
                  AvailableSeatsInfo(
                    isTodaySelected: isTodaySelected,
                    isTomorrowSelected: isTomorrowSelected,
                  ),
                  DinnerInfo(
                      // Provide necessary state or callbacks
                      ),
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
                    onPressed: () => {},
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
