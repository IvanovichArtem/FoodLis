import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfo extends StatefulWidget {
  final String profileImageUrl;
  final String name;
  final String surname;
  final String phone;
  final int scores;
  final List<String> categories;
  final String level;

  const ProfileInfo({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.surname,
    required this.phone,
    required this.scores,
    required this.categories,
    required this.level,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
// Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Вычисляем 2/3 от ширины экрана
    double imageSize = screenWidth * 2 / 3;

    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  widget.name + " " + widget.surname,
                  style: GoogleFonts.roboto(
                      color: Color.fromARGB(255, 138, 138, 142),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Color.fromARGB(255, 189, 189, 191),
                    ),
                  ],
                )
              ]),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.phone,
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 191, 191, 191),
                        fontSize: 12),
                  ),
                ],
              ),

              SizedBox(
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
                        horizontal: 8.0), // Отступы между элементами
                    child: Text(
                      "#" + category,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Color.fromARGB(255, 138, 138, 142), // Цвет серый
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 66,
                      width: 165,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 239, 239, 239)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 9,
                              ),
                              Text("Уровень " + widget.level,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 92, 92, 92),
                                  )),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: const Color.fromARGB(255, 92, 92, 92)),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // TODO: медальки
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      height: 66,
                      width: 165,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 239, 239, 239)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 9,
                              ),
                              Text("Баллы",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 92, 92, 92),
                                  )),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: const Color.fromARGB(255, 92, 92, 92)),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.scores.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 92, 92, 92)),
                            ),
                            Spacer()
                          ])
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          padding: EdgeInsets.zero,
        ));
  }
}
