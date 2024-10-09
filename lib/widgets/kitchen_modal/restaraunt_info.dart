import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestarauntInfo extends StatefulWidget {
  final String restarauntType;
  final int rating_count;
  final double ratingMean;
  final String closingDate;
  final int meanCost;
  const RestarauntInfo(
      {super.key,
      required this.restarauntType,
      required this.rating_count,
      required this.ratingMean,
      required this.closingDate,
      required this.meanCost});

  @override
  State<RestarauntInfo> createState() => _RestarauntInfoState();
}

class _RestarauntInfoState extends State<RestarauntInfo> {
  String getReviewWord(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return "$count отзыв";
    } else if (count % 10 >= 2 &&
        count % 10 <= 4 &&
        (count % 100 < 10 || count % 100 >= 20)) {
      return "$count отзыва";
    } else {
      return "$count отзывов";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 76,
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      8, 5, 10, 4), // Set your desired padding here
                  child: Text(
                    widget.restarauntType,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 114, 114, 114),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 76,
                width: 185,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        8, 10, 10, 4), // Set your desired padding here
                    child: Column(
                      children: [
                        // звезды + >
                        Row(
                          children: [
                            StarRating(rating: widget.ratingMean),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color.fromARGB(255, 114, 114, 144),
                              size: 18,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Средняя + кол-во
                        Row(
                          children: [
                            Text(
                              widget.ratingMean.toString().replaceAll('.', ','),
                              style: GoogleFonts.montserrat(
                                  color:
                                      const Color.fromARGB(255, 114, 114, 114),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Icon(Icons.circle,
                                  size: 4,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                getReviewWord(widget.rating_count),
                                style: GoogleFonts.montserrat(
                                    color: const Color.fromARGB(
                                        255, 114, 114, 114),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              // время до, Загруженность кнопка, средний чек
              Container(
                height: 30,
                width: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "до ${widget.closingDate}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 114, 114, 114),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                width: 178,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Загруженность",
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 114, 114, 114),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color.fromARGB(255, 114, 114, 144),
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                width: 75,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "${widget.meanCost} р",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 114, 114, 114),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int roundedRating = rating.ceil();

    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.5),
          child: Icon(
            index < roundedRating
                ? FontAwesomeIcons.solidStar
                : FontAwesomeIcons.star,
            color: const Color.fromARGB(255, 229, 145, 18),
            size: 18,
          ),
        );
      }),
    );
  }
}
