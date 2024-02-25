import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/upload_signed_contract.dart';

class legalResult extends StatelessWidget {
  final String summary;
  const legalResult({super.key,  required this.summary,});

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
            color: const Color(0xffd9d9d9),
            child: Text(
              summary,
              style: const TextStyle(
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
                      builder: (context) => const UploadSignedContract()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff000062),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
