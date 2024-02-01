import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/components/image_picker.dart';
import 'package:pactcheck_front/src/pages/review/store_result.dart';

class UploadSignedContract extends StatefulWidget {
  const UploadSignedContract({super.key});

  @override
  _UploadSignedContractState createState() => _UploadSignedContractState();
}

class _UploadSignedContractState extends State<UploadSignedContract> {
  List<String> selectedImagePaths = [];

  void handleImagePicked(String path) {
    setState(() {
      selectedImagePaths.add(path);
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
        children: [
          const Text(
            'Please attach the signed contract.',
            style: TextStyle(
                color: Color(0xff000062),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          const SizedBox(height: 10),
          PickImage(onImagePicked: handleImagePicked),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StoreResult()),
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
                'Save',
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
