import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/illegal_result.dart';

class UploadContract extends StatelessWidget {
  const UploadContract({super.key});

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
          // 사진 업로드 로직 추가
          const SizedBox(height: 20),
          Container(
            width: 300,
            height: 550,
            color: const Color(0xffd9d9d9),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IllegalResult()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
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
