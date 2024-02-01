import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/pages/review/upload_contract.dart';
import 'package:country_picker/country_picker.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  Country? selectedCountry;

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
      extendBodyBehindAppBar: true,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'select the country.',
                style: TextStyle(
                    color: Color(0xff000062),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    setState(() {
                      selectedCountry = country;
                    });
                  },
                );
              },
              child: Container(
                width: 320,
                height: 50,
                margin: const EdgeInsets.only(left: 30),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff000062),
                    width: 3.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedCountry != null)
                      Text(
                        selectedCountry!.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff000062),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff000062),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 300),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadContract()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffffff),
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
                  'Next',
                  style: TextStyle(
                      color: Color(0xff000062),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          ]),
    );
  }
}
