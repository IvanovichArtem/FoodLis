import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'medals.dart';

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
                  "${widget.name} ${widget.surname}",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 138, 138, 142),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Row(
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
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.phone,
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
                      height: 66,
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
                                Text("Уровень ${widget.level}",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color:
                                          const Color.fromARGB(255, 92, 92, 92),
                                    )),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Color.fromARGB(255, 92, 92, 92)),
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
                      height: 66,
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
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 92, 92, 92),
                                  )),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Color.fromARGB(255, 92, 92, 92)),
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
                              widget.scores.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  color: const Color.fromARGB(255, 92, 92, 92)),
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
