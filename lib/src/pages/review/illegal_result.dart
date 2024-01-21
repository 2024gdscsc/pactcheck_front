import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/upload_signed_contract.dart';

class IllegalResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff000062)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "There are no legal provisions\n that pose a problem",
            style: TextStyle(
                color: Color(0xff000062),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          const SizedBox(height: 40),
          Container(
            width: 300,
            height: 350,
            color: Color(0xffd9d9d9),
            child: const Text(
              "content",
              style: TextStyle(
                  color: Color(0xff000062),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UploadSignedContract()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff000062),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Sign Contract',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
