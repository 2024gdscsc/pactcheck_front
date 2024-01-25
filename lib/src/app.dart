import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/select_country.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            const SizedBox(height: 250),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectCountry()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff000062),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'contract review',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Color(0xff000062),
                    width: 3.0,
                  ),
                ),
              ),
              child: const Text(
                'past contracts',
                style: TextStyle(
                    color: Color(0xff000062),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
