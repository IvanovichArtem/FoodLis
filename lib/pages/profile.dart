import 'package:flutter/material.dart';
import 'package:food_lis/widgets/profile/booking_widget.dart';
import 'package:food_lis/widgets/profile/profile_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/profile/profile_rest_dishes_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: SingleChildScrollView(
        // Оборачиваем в SingleChildScrollView
        child: Column(
          children: [
            SizedBox(height: 10),
            ProfileInfo(
              profileImageUrl: 'assets/images/fox.jpg',
              name: 'Анна',
              surname: 'Смирнова',
              phone: '+375336639162',
              scores: 45,
              categories: ['азиатская кухня', 'роллы', 'коктейли', 'бары'],
              level: '3',
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                child: Text(
                  "Бронирования",
                  style: GoogleFonts.roboto(
                    color: Color.fromARGB(255, 92, 92, 92),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            BookingWidget(
              name: "HookahPlace Sportivnaya",
              address: "ул. Дунина-Марцинкевича д. 3, Минск",
              datetime: DateTime(2024, 8, 25, 18, 0),
              place: "У окна",
              imgUrl: 'assets/images/booking/hookahplace.jpg',
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 0, 12),
                child: Row(children: [
                  Text(
                    "Мой рейтинг",
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 92, 92, 92),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ])),
            ProfileRestDishInfo(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Профиль',
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 92, 92, 92),
            fontSize: 32),
      ),
      actions: [
        IconButton(
          icon: FaIcon(FontAwesomeIcons.bell,
              color: Color.fromARGB(255, 138, 138, 142)),
          onPressed: () {},
        ),
      ],
    );
  }
}
