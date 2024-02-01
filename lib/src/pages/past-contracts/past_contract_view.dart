import 'package:flutter/material.dart';
// import 'package:pactcheck_front/src/app.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_original_photo.dart';

class PastContractView extends StatefulWidget {
  const PastContractView({super.key});

  @override
  _PastContractViewState createState() => _PastContractViewState();
}

List<String> contracts = [
  'Employment Contract',
  'Non-Disclosure Agreement',
  'Independent Contractor Agreement',
  'Consulting Agreement',
];

class _PastContractViewState extends State<PastContractView> {
  String searchText = '';
  List<String> filteredContracts = [];

  @override
  void initState() {
    super.initState();
    filteredContracts = contracts;
  }

  void filterContracts(String query) {
    setState(() {
      filteredContracts = contracts
          .where((contract) =>
              contract.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

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
        children: <Widget>[
          Container(
            width: 318,
            height: 65,
            decoration: ShapeDecoration(
              color: Color(0x33252553),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: Color(0xFF000062)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: filterContracts,
                decoration: InputDecoration(
                  labelText: 'Clause Search',
                  hintStyle: TextStyle(
                    color: Color(0xFF000062),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF000062),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 318,
            height: 350,
            decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PastOriginalPhoto()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff000062),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Color(0xff000062),
                    width: 3.0,
                  ),
                ),
              ),
              child: const Text(
                'View Original',
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
