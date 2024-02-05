import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/components/photo_gallery.dart';

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
        title: const Text(
          'Past Contracts',
          style: TextStyle(
            color: Color(0xFF000062),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              width: 400,
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
            const SizedBox(height: 20),
            PhotoGallery()
          ],
        ),
      ),
    );
  }
}
