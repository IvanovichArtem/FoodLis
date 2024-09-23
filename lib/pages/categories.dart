import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_lis/widgets/categories/categories_restaraunts_info.dart';
import 'package:food_lis/widgets/categories/kitchens.dart';
import 'package:food_lis/widgets/categories/search_bar.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';

class Categoires extends StatefulWidget {
  const Categoires({super.key});

  @override
  State<Categoires> createState() => _CategoiresState();
}

class _CategoiresState extends State<Categoires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CategoryAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 7), // Отступ 20 пикселей сверху
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4A261), // Цвет фона
                  borderRadius: BorderRadius.circular(16.0), // Скругление углов
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Обеденное меню\nв ресторане MIMO\nот 5 рублей',
                      style: TextStyle(
                        color: Colors.white, // Цвет текста
                        fontSize: 20.0, // Размер шрифта
                        fontWeight: FontWeight.bold, // Жирный шрифт
                      ),
                    ),
                    SizedBox(height: 8.0), // Отступ между текстами
                    Text(
                      'Первомайская 5',
                      style: TextStyle(
                        color: Colors.white, // Цвет текста
                        fontSize: 16.0, // Размер шрифта
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Здесь кухни
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Распределение с краями
                children: [
                  KitchenItem(
                    name: 'Завтрак',
                    imageUrl: 'assets/images/kitchens/завтрак.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Бранч',
                    imageUrl: 'assets/images/kitchens/бранч.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Обед',
                    imageUrl: 'assets/images/kitchens/обед.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Ужин',
                    imageUrl: 'assets/images/kitchens/ужин.jpg',
                    width: 73,
                    height: 73,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Распределение с краями
                children: [
                  Column(
                    children: [
                      KitchenItem(
                        name: 'Азиатская кухня',
                        imageUrl: 'assets/images/kitchens/азиатская кухня.jpg',
                        width: 158,
                        height: 170,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        name: 'Pet friendly',
                        imageUrl: 'assets/images/kitchens/пет.jpg',
                        width: 158,
                        height: 73,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      KitchenItem(
                        name: 'Терасса',
                        imageUrl: 'assets/images/kitchens/терассы.jpg',
                        width: 158,
                        height: 73,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        name: 'Итальянская кухня',
                        imageUrl:
                            'assets/images/kitchens/итальянская кухня.jpg',
                        width: 158,
                        height: 170,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KitchenItem(
                    name: 'Кофе',
                    imageUrl: 'assets/images/kitchens/кофе.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Пиво',
                    imageUrl: 'assets/images/kitchens/пиво.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Коктейли',
                    imageUrl: 'assets/images/kitchens/коктейли.jpg',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: '24 часа',
                    imageUrl: 'assets/images/kitchens/24.jpg',
                    width: 73,
                    height: 73,
                  ),
                ],
              ),
            ),

            //Специально для вас
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 7, 0, 10),
              child: Text(
                "Специально для вас",
                style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 92, 92, 92),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const PersonalizedInfoWidget(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(120); // Увеличиваем высоту AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      elevation: 0,
      // цвет прозранчый
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false, // Отключаем кнопку "назад" по умолчанию
      title: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Выравнивание по левому краю
        children: [
          // Первая строка с заголовком и действиями
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Категории',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 92, 92, 92),
                  fontSize: 32,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.heart,
                      color: Color.fromARGB(255, 138, 138, 142),
                    ),
                    splashColor: const Color.fromARGB(
                        255, 132, 132, 132), // Цвет при нажатии

                    highlightColor: const Color.fromARGB(
                        255, 136, 136, 136), // Цвет при нажатии
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.bell,
                      color: Color.fromARGB(255, 138, 138, 142),
                    ),
                    splashColor: const Color.fromARGB(
                        255, 132, 132, 132), // Цвет при нажатии

                    highlightColor: const Color.fromARGB(255, 136, 136, 136),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10), // Отступ между строками
          // Вторая строка с поисковой строкой
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(
                  height: 36,
                  child: SearchInput(), // Ваш виджет поисковой строки
                ),
              ),
              const SizedBox(width: 8), // Промежуток между элементами
              GestureDetector(
                onTap: () {
                  showCustomBottomSheet(
                      context); // Вызываем функцию из другого файла
                },
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 175, 79),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.sliders,
                    color: Colors.white,
                    size: 16,
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
