import 'dart:js';

import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_contract_view.dart';

class PastContractsList extends StatefulWidget {
  const PastContractsList({super.key});

  @override
  _PastContractsListState createState() => _PastContractsListState();
}

class _PastContractsListState extends State<PastContractsList> {
  List<String> contracts = [
    'Employment Contract',
    'Non-Disclosure Agreement',
    'Independent Contractor Agreement',
    'Consulting Agreement',
  ];

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
        title: const Text('Past Contracts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320,
            height: 65,
            decoration: ShapeDecoration(
              color: Color(0x33242452),
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
                  labelText: 'Search',
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
          Expanded(
            child: Container(
              width: 320,
              height: 65,
              child: ListView.builder(
                itemCount: filteredContracts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PastContractView(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 3, color: Color(0xFF000062)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          filteredContracts[index],
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color(0xFF000062),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
