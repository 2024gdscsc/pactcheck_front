import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/app.dart';

class PastContractsList extends StatefulWidget {
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
        title: Text('Past Contracts'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: filterContracts,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContracts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 65,
                  margin: EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Color(0xFF000062)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      filteredContracts[index],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF000062),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
