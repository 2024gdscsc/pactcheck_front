import 'package:flutter/material.dart';
// import 'package:pactcheck_front/src/pages/past-contracts/past_contract_view.dart';
import 'package:pactcheck_front/src/components/hash_modal.dart';

class PhotoGallery extends StatefulWidget {
  PhotoGallery({super.key});
  // Example original photo URL
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

@override
class _PhotoGalleryState extends State<PhotoGallery> {
  final String originalPhotoUrl = 'assets/images/ex1.jpg';
  // Example thumbnail URLs
  final List<String> thumbnailUrls = [
    'assets/images/ex1.jpg',
    'assets/images/ex2.jpg',
    'assets/images/ex3.jpg',
    // Add more thumbnail URLs as needed
  ];

  var shownindex = 0;

  void Tapped(index) {
    setState(() {
      shownindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: Column(children: [
        Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                thumbnailUrls[shownindex],
                width: 400,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: const PopHashModal())
          ],
        ),
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: thumbnailUrls.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Tapped(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      thumbnailUrls[index],
                      width: 60, // Adjust the width as needed
                      height: 80, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          ),
        )
      ]),
    );
  }
}
