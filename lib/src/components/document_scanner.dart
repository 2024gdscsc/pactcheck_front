import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';

class PickImage extends StatefulWidget {
  final Function(String) onImagePicked;

  const PickImage({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final ImagePicker picker = ImagePicker();
  List<XFile> _images = [];
  File? _scannedImage;
  int _currentPageIndex = 0;

  /*
  XFile? _image;
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
      widget.onImagePicked(pickedFile.path);
    }
    Navigator.pop(context);
  }*/

  // Future getImages(ImageSource imageSource) async {
  //   try {
  //     final List<XFile>? pickedFiles = await picker.pickMultiImage();
  //     if (pickedFiles != null && pickedFiles.isNotEmpty) {
  //       setState(() {
  //         _images = pickedFiles;
  //       });

  //       pickedFiles.forEach((file) {
  //         widget.onImagePicked(file.path);
  //       });
  //     }
  //     Navigator.pop(context);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPhotoArea(),
                  if (_images.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Image ${_currentPageIndex + 1} of ${_images.length}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000062)),
                      ),
                    ),
                ])));
  }

  Widget _buildPhotoArea() {
    return Container(
      width: double.infinity,
      height: 550,
      child: _images.isNotEmpty
          ? PageView.builder(
              itemCount: _images.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.file(
                  File(_images[index].path),
                  fit: BoxFit.cover,
                );
              },
            )
          : DottedBorder(
              color: Color(0xff000062),
              strokeWidth: 1,
              dashPattern: [2, 3],
              radius: const Radius.circular(5),
              borderType: BorderType.RRect,
              child: Container(
                  width: double.infinity,
                  height: 550,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_a_photo_rounded,
                              color: Color(0xff000062)),
                          iconSize: 30,
                          onPressed: () => openImageScanner(context),
                        ),
                        const Text(
                          "Attaching Photo",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000062)),
                        )
                      ])),
            ),
    );
  }

  void _buildButton(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0xffffffff),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        openImageScanner(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.image,
                                size: 70, color: Color(0xff000062)),
                            Text("Gallery",
                                style: TextStyle(color: Color(0xff000062)))
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     onTap: () {
                  //       getImages(ImageSource.camera);
                  //     },
                  //     child: const SizedBox(
                  //       child: Column(
                  //         children: [
                  //           Icon(Icons.camera_alt,
                  //               size: 70, color: Color(0xff000062)),
                  //           Text("Camera",
                  //               style: TextStyle(color: Color(0xff000062)))
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
