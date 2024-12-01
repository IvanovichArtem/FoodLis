import 'package:flutter/material.dart';
import 'package:food_lis/widgets/profile/booking_widget.dart';
import 'package:food_lis/widgets/profile/my_reviews.dart';
import 'package:food_lis/widgets/profile/profile_buttons.dart';
import 'package:food_lis/widgets/profile/profile_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_lis/widgets/profile/profile_rest_dishes_info.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const ProfileInfo(
              profileImageUrl: 'assets/images/fox.jpg',
              scores: 45,
              categories: ['азиатская кухня', 'роллы', 'коктейли', 'бары'],
              level: 3,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 12, 0, 0),
                child: Text(
                  "Бронирования",
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 48, 48, 48),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            BookingWidget(),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 0, 12),
                child: Row(children: [
                  Text(
                    "Мой рейтинг",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 48, 48, 48),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ])),
            const ProfileRestDishInfo(),
            const SizedBox(
              height: 10,
            ),
            const MyReviews(),
            const SizedBox(
              height: 10,
            ),
            const ProfileButtons()
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Профиль',
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w800,
            color: const Color.fromARGB(255, 48, 48, 48),
            fontSize: 28),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.bell,
                    color: Color.fromARGB(255, 138, 138, 142)),
                onPressed: () {},
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset('assets/svg/setting.svg'),
            ],
          ),
        )
      ],
    );
  }
}
