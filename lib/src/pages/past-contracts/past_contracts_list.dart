import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_contract_view.dart';
import 'package:dio/dio.dart';

class PastContractsList extends StatefulWidget {
  const PastContractsList({super.key});

  @override
  _PastContractsListState createState() => _PastContractsListState();
}

class ContractInformation {
  final int id;
  final String document_name;
  final DateTime agreement_date;
  final DateTime effective_date;
  final String governing_law;
  final List<String> parties;
  final int initial_term;
  final String notice_to_terminate_renewal;
  final int renewal_term;
  final String summary;
  final List<String> key_points;

  ContractInformation({
    required this.id,
    required this.document_name,
    required this.agreement_date,
    required this.effective_date,
    required this.governing_law,
    required this.parties,
    required this.initial_term,
    required this.notice_to_terminate_renewal,
    required this.renewal_term,
    required this.summary,
    required this.key_points,
  });

  factory ContractInformation.fromJson(Map<String, dynamic> json) {
    return ContractInformation(
      id: json['id'] as int,
      document_name: json['document_name'] as String,
      agreement_date: DateTime.parse(json['agreement_date'] as String),
      effective_date: DateTime.parse(json['effective_date'] as String),
      governing_law: json['governing_law'] as String,
      parties: (json['parties'] as List).map((e) => e as String).toList(),
      initial_term: json['initial_term'] as int,
      notice_to_terminate_renewal:
          json['notice_to_terminate_renewal'] as String,
      renewal_term: json['renewal_term'] as int,
      summary: json['summary'] as String,
      key_points: (json['key_points'] as List).map((e) => e as String).toList(),
    );
  }
}

// Define other classes like Party and NoticeToTerminateRenewal based on their schemas

class _PastContractsListState extends State<PastContractsList> {
  List<ContractInformation> contracts = [];

  List<ContractInformation> filteredContracts = [];

  @override
  void initState() {
    super.initState();
    filteredContracts = contracts;
    fetchContracts();
  }

  Future fetchContracts() async {
    try {
      var dio = Dio();
      var response = await dio.get('/rec/contract/list');
      var contractData = response.data as List;
      contracts =
          contractData.map((e) => ContractInformation.fromJson(e)).toList();
      setState(() {});
    } catch (e) {
      print("Error fetching contracts: $e");
      // Handle error gracefully, e.g., display an error message
    }
  }

  void filterContracts(String query) {
    setState(() {
      filteredContracts = contracts
          .where((contract) => contract.document_name
              .toLowerCase()
              .contains(query.toLowerCase()))
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
                            builder: (context) => PastContractView(
                                contractId: filteredContracts[index].id),
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
                                filteredContracts[index].document_name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFF000062),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${filteredContracts[index].agreement_date} (${filteredContracts[index].effective_date})',
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '2',
                  style: const TextStyle(
                    color: Color(0xFF000062),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '3',
                  style: const TextStyle(
                    color: Color(0xFF000062),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
