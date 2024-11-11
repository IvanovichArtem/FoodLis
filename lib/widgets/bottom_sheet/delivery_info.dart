import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/bottom_sheet/custom_toogle_switch.dart';

class DeliveryInfo extends StatefulWidget {
  final bool isYandexSelected;
  final bool isDeliverySelected;
  final bool isRestaurantSelected;

  const DeliveryInfo({
    super.key,
    required this.isYandexSelected,
    required this.isDeliverySelected,
    required this.isRestaurantSelected,
  });

  @override
  State<DeliveryInfo> createState() => DeliveryInfoState();
}

class DeliveryInfoState extends State<DeliveryInfo> {
  late ValueNotifier<bool> isYandexSelectedNotifier;
  late ValueNotifier<bool> isDeliverySelectedNotifier;
  late ValueNotifier<bool> isRestaurantSelectedNotifier;
  late ValueNotifier<bool> isToggleSwitchSelectedNotifier;

  @override
  void initState() {
    super.initState();
    isYandexSelectedNotifier = ValueNotifier(widget.isYandexSelected);
    isDeliverySelectedNotifier = ValueNotifier(widget.isDeliverySelected);
    isRestaurantSelectedNotifier = ValueNotifier(widget.isRestaurantSelected);
    isToggleSwitchSelectedNotifier = ValueNotifier(false); // Начальное значение
  }

  @override
  void dispose() {
    isYandexSelectedNotifier.dispose();
    isDeliverySelectedNotifier.dispose();
    isRestaurantSelectedNotifier.dispose();
    isToggleSwitchSelectedNotifier.dispose();
    super.dispose();
  }

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
                style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              CustomToggleSwitch(
                  isSelectedNotifier: isToggleSwitchSelectedNotifier),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSelectableButton('Яндекс', isYandexSelectedNotifier),
              _buildSelectableButton('Delivery', isDeliverySelectedNotifier),
              _buildSelectableButton('Ресторан', isRestaurantSelectedNotifier),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableButton(String label, ValueNotifier<bool> notifier) {
    return GestureDetector(
      onTap: () {
        notifier.value = !notifier.value;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: notifier,
        builder: (context, isSelected, child) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 110),
            height: 25,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 243, 175, 79)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : const Color.fromARGB(255, 190, 190, 190),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 191, 191, 191),
              ),
            ),
          );
        },
      ),
    );
  }

  void reset() {
    isYandexSelectedNotifier.value = false;
    isDeliverySelectedNotifier.value = false;
    isRestaurantSelectedNotifier.value = false;
    isToggleSwitchSelectedNotifier.value = false;
  }

  getCurrentState() {
    if (isToggleSwitchSelectedNotifier.value) {
      return {
        'isYandexSelected': isYandexSelectedNotifier.value,
        'isDeliverySelected': isDeliverySelectedNotifier.value,
        'isRestaurantSelected': isRestaurantSelectedNotifier.value
      };
    }
  }
}
