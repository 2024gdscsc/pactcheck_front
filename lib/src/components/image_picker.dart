import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pactcheck_front/src/components/text_highlight.dart';

class PickImage extends StatefulWidget {
  final Function(String) onImagePicked;

  const PickImage({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final ImagePicker picker = ImagePicker();
  List<XFile> _images = [];
  int _currentPageIndex = 0;

  Future getImages(ImageSource imageSource) async {
    try {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _images = pickedFiles;
        });

        pickedFiles.forEach((file) {
          widget.onImagePicked(file.path);
        });
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
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
                          onPressed: () => _buildButton(context),
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
                        getImages(ImageSource.gallery);
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
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImages(ImageSource.camera);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt,
                                size: 70, color: Color(0xff000062)),
                            Text("Camera",
                                style: TextStyle(color: Color(0xff000062)))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
