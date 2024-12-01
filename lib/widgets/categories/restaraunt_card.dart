import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_modal.dart';

class RestarauntCard extends StatefulWidget {
  final String docId;
  final String name;
  final String imageUrl;
  final String restarauntType;
  final String endTime;
  final double avgReview;
  final int cntReviews;
  final int timeByWalk;
  final int avgPrice;
  final bool isToogle;
  final String videoUrl;
  final String siteUrl;
  final String instaUrl;

  const RestarauntCard({
    super.key,
    required this.name,
    required this.cntReviews,
    required this.imageUrl,
    required this.docId,
    required this.restarauntType,
    required this.endTime,
    required this.avgReview,
    required this.timeByWalk,
    required this.avgPrice,
    required this.isToogle,
    required this.videoUrl,
    required this.siteUrl,
    required this.instaUrl,
  });

  @override
  State<RestarauntCard> createState() => _RestarauntCardState();
}

class _RestarauntCardState extends State<RestarauntCard> {
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
    return GestureDetector(
      onTap: () {
        showRestBottomSheet(context,
            restId: widget.docId,
            name: widget.name,
            imageUrl: widget.imageUrl,
            restarauntType: widget.restarauntType,
            endTime: widget.endTime,
            avgReview: widget.avgReview,
            cntReviews: widget.cntReviews,
            timeByWalk: 5,
            avgPrice: widget.avgPrice,
            isToogle: false,
            videoUrl: widget.videoUrl,
            instaUrl: widget.instaUrl,
            siteUrl: widget.siteUrl);
      },
      child: Container(
        width: 140,
        height: 196,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 235, 235, 235)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                width: 140,
                fit: BoxFit.fill,
                height: 300,
                alignment: Alignment.topCenter,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: const Color.fromARGB(255, 243, 175, 79),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 48,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 3, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              widget.avgReview.toString().replaceAll('.', ','),
                              style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 1),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.orange,
                              size: 10,
                            ),
                            Text(
                              " ${getReviewWord(widget.cntReviews)}",
                              style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 114, 114, 114),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
