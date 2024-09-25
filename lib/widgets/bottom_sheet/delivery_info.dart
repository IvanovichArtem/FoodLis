import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/bottom_sheet/custom_toogle_switch.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  bool isYandexSelected = false;
  bool isDeliverySelected = false;
  bool isRestaurantSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Наличие доставки",
                style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const CustomToggleSwitch(),
            ],
          ),
          const SizedBox(height: 7), // Отступ между заголовком и кнопками
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isYandexSelected = !isYandexSelected;
                  });
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  height: 25,
                  decoration: BoxDecoration(
                    color: isYandexSelected
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !isYandexSelected
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // Закругленные края
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Яндекс',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: isYandexSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDeliverySelected = !isDeliverySelected;
                  });
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  height: 25,
                  decoration: BoxDecoration(
                    color: isDeliverySelected
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !isDeliverySelected
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Delivery',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: isDeliverySelected
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isRestaurantSelected = !isRestaurantSelected;
                  });
                },
                child: Container(
                  height: 25,
                  width: 130,
                  decoration: BoxDecoration(
                    color: isRestaurantSelected
                        ? const Color.fromARGB(255, 243, 175, 79)
                        : Colors.transparent,
                    border: Border.all(
                      color: !isRestaurantSelected
                          ? const Color.fromARGB(255, 190, 190, 190)
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'От ресторана',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: isRestaurantSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 191, 191, 191),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}