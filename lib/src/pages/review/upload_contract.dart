import 'package:flutter/material.dart';
//import 'package:pactcheck_front/src/components/document_scanner.dart';
import 'package:pactcheck_front/src/pages/review/legal_result.dart';
import 'package:pactcheck_front/src/pages/review/illegal_result.dart';
import 'package:pactcheck_front/src/repository/image_repository.dart';
import 'package:pactcheck_front/src/components/image_picker.dart';
import 'package:pactcheck_front/src/components/loading_screen.dart';
import 'package:dio/dio.dart';

class UploadContract extends StatefulWidget {
  const UploadContract({super.key});

  @override
  _UploadContractState createState() => _UploadContractState();
}

class _UploadContractState extends State<UploadContract> {
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
          const SizedBox(height: 20),
          PickImage(onImagePicked: handleImagePicked),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  //uploadImage(selectedImagePaths);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingScreen()),
                  );
                } catch (e) {
                  print(e);
                }
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
        ],
      ),
    );
  }
}
