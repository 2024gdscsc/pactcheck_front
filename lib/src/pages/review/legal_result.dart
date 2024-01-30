import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/app.dart';

class LegalResult extends StatelessWidget {
  const LegalResult({super.key});

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
          const Row(
            children: [
              Text(
                "Review the following ",
                style: TextStyle(
                    color: Color(0xff000062),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              Text(
                "legal ",
                style: TextStyle(
                    color: Color(0xff000062),
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Text(
                "provisions",
                style: TextStyle(
                    color: Color(0xff000062),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            width: 300,
            height: 350,
            color: const Color(0xffd9d9d9),
            child: const Text(
              "content",
              style: TextStyle(
                  color: Color(0xff000062),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const App()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Color(0xff000062),
                    width: 3.0,
                  ),
                ),
              ),
              child: const Text(
                'Back to Main',
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
