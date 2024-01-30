import 'package:flutter/material.dart';

class PastOriginalPhoto extends StatelessWidget {
  PastOriginalPhoto({super.key});
  // Example original photo URL
  final String originalPhotoUrl = 'assets/images/contract.jpg';

  // Example thumbnail URLs
  final List<String> thumbnailUrls = [
    'assets/images/contract.jpg',
    'assets/images/contract.jpg',
    'assets/images/contract.jpg',
    // Add more thumbnail URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff000062)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: const [],
        title: Text(
          'View Original',
          style: TextStyle(
            color: Color(0xff000062),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          child: Column(children: [
            Container(
              width: 300,
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.asset(
                  originalPhotoUrl,
                  width: 300, // Adjust the width as needed
                  height: 400, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: thumbnailUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      thumbnailUrls[index],
                      width: 80, // Adjust the width as needed
                      height: 80, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            )
          ]),
          transformAlignment: Alignment.center,
        ),
      ),
    );
  }
}
