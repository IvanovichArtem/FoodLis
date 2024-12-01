import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_lis/widgets/map/search_bar_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/modal_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListMapItem extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String restarauntType;
  final double avgReview;
  final int cntReviews;
  final int timeByWalk;
  final int avgPrice;
  final bool isToogle;
  final String endTime;
  final String documentId;
  final String videoUrl;
  final String siteUrl;
  final String instaUrl;

  const ListMapItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.restarauntType,
    required this.avgReview,
    required this.cntReviews,
    required this.timeByWalk,
    required this.avgPrice,
    required this.isToogle,
    required this.documentId,
    required this.endTime,
    required this.videoUrl,
    required this.siteUrl,
    required this.instaUrl,
    // Добавляем новый параметр
  });

  @override
  _ListMapItemState createState() => _ListMapItemState();
}

class _ListMapItemState extends State<ListMapItem> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isToogle; // Инициализируем текущее состояние
  }

  // Метод для обновления состояния в Firestore и изменения иконки

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

  void _showRestaurantDetails() {
    showRestBottomSheet(context,
        restId: widget.documentId,
        name: widget.name,
        imageUrl: widget.imageUrl,
        restarauntType: widget.restarauntType,
        timeByWalk: 5,
        endTime: widget.endTime,
        avgPrice: widget.avgPrice,
        avgReview: widget.avgReview,
        cntReviews: widget.cntReviews,
        isToogle: isBookmarked,
        videoUrl: widget.videoUrl,
        siteUrl: widget.siteUrl,
        instaUrl: widget.instaUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
      child: GestureDetector(
        onTap:
            _showRestaurantDetails, // Добавляем вызов модального окна при нажатии
        child: Container(
          child: Row(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                clipBehavior: Clip.hardEdge,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    height: 140,
                    width: 120,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 160.5,
                            height: 25,
                            child: Text(
                              widget.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                  color: const Color.fromARGB(255, 48, 48, 48),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(Icons.more_vert,
                              color: Color.fromARGB(255, 220, 220, 220)),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 190,
                      child: Text(widget.restarauntType,
                          style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 114, 114, 114),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.solidStar,
                          color: Color.fromARGB(255, 229, 145, 18),
                          size: 14,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.avgReview.toString().replaceAll('.', ','),
                          style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 114, 114, 114),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Icon(Icons.circle,
                              size: 4,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            getReviewWord(widget.cntReviews),
                            style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 114, 114, 114),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 234, 234, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.car,
                                  color: Color.fromARGB(255, 175, 175, 175),
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${widget.timeByWalk} мин",
                                  style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(
                                          255, 175, 175, 175),
                                      fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 50,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 234, 234, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.avgPrice} Br",
                                  style: GoogleFonts.montserrat(
                                      color: const Color.fromARGB(
                                          255, 175, 175, 175),
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 38,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
