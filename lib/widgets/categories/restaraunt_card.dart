import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_lis/widgets/kitchen_modal/restaraunt_modal.dart';

class RestarauntCard extends StatefulWidget {
  final String docId;
  final String name;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  const RestarauntCard({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.docId,
  });

  @override
  State<RestarauntCard> createState() => _RestarauntCardState();
}

class _RestarauntCardState extends State<RestarauntCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showRestBottomSheet(
          context,
          restId: widget.docId,
          name: widget.name,
          imageUrl: widget.imageUrl,
        );
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
                              widget.rating.toString().replaceAll('.', ','),
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
                              "  ${widget.reviewCount} отзыва",
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
