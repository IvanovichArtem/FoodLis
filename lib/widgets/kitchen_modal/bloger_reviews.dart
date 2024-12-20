import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_lis/widgets/kitchen_modal/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogerReviews extends StatelessWidget {
  final String siteUrl;
  final String name;
  final String videoUrl;
  final String instaUrl;
  static const Color greyMedium = Color.fromARGB(255, 114, 114, 114);

  const BlogerReviews(
      {super.key,
      required this.siteUrl,
      required this.videoUrl,
      required this.instaUrl,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ссылки",
                  style: GoogleFonts.montserrat(
                      color: greyMedium,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                    height: 2, color: Color.fromARGB(255, 235, 235, 235))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Instagram Button
                InkWell(
                  onTap: () {
                    // Открытие Instagram URL
                    launch(
                        instaUrl); // используйте `launch` из пакета `url_launcher`
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: greyMedium,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Instagram Text
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.montserrat(
                      color: greyMedium,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis, // Для текста с многоточием
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                // Website Button
                InkWell(
                  onTap: () {
                    // Открытие Website URL
                    launch(
                        siteUrl); // используйте `launch` из пакета `url_launcher`
                  },
                  child: const Icon(
                    Icons.language,
                    color: greyMedium,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Website Text
                Text(
                  '$name.by',
                  style: GoogleFonts.montserrat(
                    color: greyMedium,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis, // Для текста с многоточием
                ),
              ],
            ),
          ),
          YoutubePlayerWidget(videoUrl: videoUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Text(
              "Обзоры от блогеров",
              style: GoogleFonts.montserrat(
                  color: greyMedium, fontSize: 14, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
