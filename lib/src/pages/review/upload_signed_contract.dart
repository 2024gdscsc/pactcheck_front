import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/store_result.dart';

class UploadSignedContract extends StatelessWidget {
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
          SizedBox(height: 20),
          const Text(
            'Please attach the signed contract.',
            style: TextStyle(
                color: Color(0xff000062),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          SizedBox(height: 40),
          Container(
            width: 300,
            height: 450,
            color: Color(0xffd9d9d9),
          ),
          SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreResult()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffffffff),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Color(0xff000062),
                    width: 3.0,
                  ),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                    color: Color(0xff000062),
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
