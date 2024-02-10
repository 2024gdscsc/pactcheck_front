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

  List<String> contractDate = [
    DateTime.now().toString(),
    DateTime.now().add(Duration(days: 1)).toString(),
    DateTime.now().add(Duration(days: 2)).toString(),
    DateTime.now().add(Duration(days: 3)).toString(),
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
              height: 65,
              decoration: ShapeDecoration(
                color: Color.fromARGB(51, 121, 121, 128),
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
            const SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                width: 400,
                height: 150,
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
                        margin: const EdgeInsets.all(5),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                filteredContracts[index],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFF000062),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                contractDate[index],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFF000062),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: IconButton(
                        iconSize: 15,
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Color(0xff000062)),
                        onPressed: () {}),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '1',
                      style: const TextStyle(
                        color: Color(0xFF000062),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //   child: Text(
                  //     '2',
                  //     style: const TextStyle(
                  //       color: Color(0xFF000062),
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 5.0),
                  //   child: Text(
                  //     '3',
                  //     style: const TextStyle(
                  //       color: Color(0xFF000062),
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 50,
                    child: IconButton(
                        iconSize: 15,
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Color(0xff000062)),
                        onPressed: () {}),
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
