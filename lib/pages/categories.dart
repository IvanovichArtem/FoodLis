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
      appBar: CategoryAppBar(showFilter: widget.onSearch),
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
                    id: 'Завтрак',
                    name: 'Завтрак',
                    width: 73,
                    height: 73,
                    field: 'x',
                  ),
                  KitchenItem(
                      id: 'Бранч',
                      name: 'Бранч',
                      width: 73,
                      height: 73,
                      field: 'x'),
                  KitchenItem(
                      id: 'Обед',
                      name: 'Обед',
                      width: 73,
                      height: 73,
                      field: 'x'),
                  KitchenItem(
                      id: 'Ужин',
                      name: 'Ужин',
                      width: 73,
                      height: 73,
                      field: 'x'),
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
                        id: 'Азиатская',
                        name: 'Азиатская кухня',
                        width: 158,
                        height: 170,
                        field: 'kitchenType',
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        id: 'Pet friendly',
                        name: 'Pet friendly',
                        width: 158,
                        height: 73,
                        field: 'features',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      KitchenItem(
                        name: 'Терасса',
                        id: 'Терраса',
                        width: 158,
                        height: 73,
                        field: 'features',
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      KitchenItem(
                        id: 'Итальянская',
                        name: 'Итальянская кухня',
                        width: 158,
                        height: 170,
                        field: 'kitchenType',
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
                    id: 'Кофе',
                    name: 'Кофе',
                    width: 73,
                    height: 73,
                    field: 'x',
                  ),
                  KitchenItem(
                    id: 'Пиво',
                    name: 'Пиво',
                    width: 73,
                    height: 73,
                    field: 'x',
                  ),
                  KitchenItem(
                    id: 'Коктейли',
                    name: 'Коктейли',
                    width: 73,
                    height: 73,
                    field: 'x',
                  ),
                  KitchenItem(
                    id: '24 часа',
                    name: '24 часа',
                    width: 73,
                    height: 73,
                    field: 'features',
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
  final showFilter;
  const CategoryAppBar({super.key, this.showFilter});

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
                  showCustomBottomSheet(context, showFilter,
                      true); // Вызываем функцию из другого файла
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
                  child: SearchInput(),
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
