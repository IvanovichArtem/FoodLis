import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_lis/widgets/categories/categories_restaraunts_info.dart';
import 'package:food_lis/widgets/categories/kitchens.dart';
import 'package:food_lis/widgets/categories/search_bar.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';
import 'package:food_lis/widgets/categories/add_widget.dart';

class Categoires extends StatefulWidget {
  final onSearch;
  final onAllRest;
  const Categoires({super.key, this.onSearch, this.onAllRest});

  @override
  State<Categoires> createState() => _CategoiresState();
}

class _CategoiresState extends State<Categoires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryAppBar(func: widget.onSearch),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalScrollAddWidget(),

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
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Бранч',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Обед',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Ужин',
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
                        width: 158,
                        height: 170,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        name: 'Pet friendly',
                        width: 158,
                        height: 73,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      KitchenItem(
                        name: 'Терасса',
                        width: 158,
                        height: 73,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        name: 'Итальянская кухня',
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
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Пиво',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: 'Коктейли',
                    width: 73,
                    height: 73,
                  ),
                  KitchenItem(
                    name: '24 часа',
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
                style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 48, 48, 48),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            PersonalizedInfoWidget(
              onAllRest: widget.onAllRest,
            ),
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
  final func;
  const CategoryAppBar({super.key, this.func});

  @override
  Size get preferredSize =>
      const Size.fromHeight(150); // Увеличиваем высоту AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      elevation: 0,
      // цвет прозранчый
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false, // Отключаем кнопку "назад" по умолчанию
      title: Column(
        children: [
          // Первая строка с заголовком и действиями
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 15),
                child: Text(
                  'Категории',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 48, 48, 48),
                    fontSize: 28,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                child: Row(
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.bell,
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
                        FontAwesomeIcons.bookmark,
                        color: Color.fromARGB(255, 138, 138, 142),
                      ),
                      splashColor: const Color.fromARGB(
                          255, 132, 132, 132), // Цвет при нажатии

                      highlightColor: const Color.fromARGB(255, 136, 136, 136),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8), // Промежуток между элементами
          // Вторая строка с поисковой строкой
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCustomBottomSheet(
                      context, () => {}); // Вызываем функцию из другого файла
                },
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 175, 79),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/filter.svg',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: SearchInput(
                    onTap: func,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22,
          )
        ],
      ),
    );
  }
}
