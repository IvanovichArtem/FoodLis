import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'medals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileInfo extends StatefulWidget {
  final String profileImageUrl;
  final int scores;
  final List<String> categories;
  final int level;

  const ProfileInfo({
    super.key,
    required this.profileImageUrl,
    required this.scores,
    required this.categories,
    required this.level,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String name = '';
  String surname = '';
  String phone = '';
  int level = 1;
  int scores = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Метод для получения данных пользователя из Firestore
  Future<void> fetchUserData() async {
    // Получаем текущего пользователя
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String uid = currentUser.uid; // Получаем UID пользователя

      // Обращаемся к коллекции "users" для получения данных
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Извлекаем необходимые поля
      setState(() {
        name = userDoc['name'];
        surname = userDoc['surname'];
        phone = userDoc['phoneNumber'];
        level = 4;
        scores = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
// Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Вычисляем 2/3 от ширины экрана
    double imageSize = screenWidth * 2 / 3;

    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "$name $surname",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 114, 114, 114),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: Color.fromARGB(255, 114, 114, 114),
                    ),
                  ],
                )
              ]),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    phone,
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 191, 191, 191),
                        fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              // изображение
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  widget.profileImageUrl,
                  width: imageSize,
                  height: imageSize,
                )
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0), // Отступы между элементами
                    child: Text(
                      "#$category",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: const Color.fromARGB(
                            255, 243, 175, 79), // Цвет серый
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 71,
                      width: 165,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 239, 239, 239)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 4, 12, 0),
                            child: Row(
                              children: [
                                Text("Уровень ${level}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 114, 114, 114),
                                    )),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color.fromARGB(255, 48, 48, 48)),
                              ],
                            ),
                          ),
                          Medals(),
                          // TODO: медальки
                        ],
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      height: 71,
                      width: 165,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 239, 239, 239)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 9,
                              ),
                              Text("Баллы",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 114, 114, 114),
                                  )),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Color.fromARGB(255, 48, 48, 48)),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              scores.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 41, 41, 41)),
                            ),
                            const Spacer()
                          ])
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
