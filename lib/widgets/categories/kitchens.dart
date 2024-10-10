import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class KitchenItem extends StatefulWidget {
  final String name;
  final double height;
  final double width;

  const KitchenItem({
    super.key,
    required this.name,
    required this.width,
    required this.height,
  });

  @override
  _KitchenItemState createState() => _KitchenItemState();
}

class _KitchenItemState extends State<KitchenItem> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchImageUrl();
  }

  Future<void> fetchImageUrl() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('categories')
          .where('name', isEqualTo: widget.name)
          .limit(1)
          .get();

      if (doc.docs.isNotEmpty) {
        final storagePath = doc.docs.first['imageUrl'];
        final url =
            await FirebaseStorage.instance.ref(storagePath).getDownloadURL();

        setState(() {
          imageUrl = url;
        });
      }
    } catch (e) {
      print('Error fetching image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl!,
              width: widget.width,
              height: widget.height,
              fit: BoxFit.cover,
            ),
          )
        else
          CircularProgressIndicator(
            color: Color.fromARGB(255, 243, 175, 79),
          ),
        Text(
          widget.name,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
