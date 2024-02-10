import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/app.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_contract_view.dart';

class StoreResult extends StatelessWidget {
  const StoreResult({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Safely stored in PactCheck!",
              style: TextStyle(
                  color: Color(0xff000062),
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const SizedBox(height: 250),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PastContractView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff000062),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'View the contract',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PastContractView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff000062),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'See Blockchain Hash',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const App()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
          ],
        ),
      ),
    );
  }
}
