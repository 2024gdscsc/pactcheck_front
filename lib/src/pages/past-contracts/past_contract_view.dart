import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pactcheck_front/src/components/photo_gallery.dart';
import 'package:pactcheck_front/src/components/image_picker.dart';
import 'package:pactcheck_front/src/components/extract_text.dart';
import 'package:dio/dio.dart';
import '../../components/text_highlight.dart';
import 'package:pactcheck_front/src/pages/past-contracts/past_contracts_list.dart';

class PastContractView extends StatefulWidget {
  final int contractId;
  const PastContractView({super.key, required this.contractId});

  @override
  _PastContractViewState createState() => _PastContractViewState();
}

class _PastContractViewState extends State<PastContractView> {
  final TextEditingController _controller = TextEditingController();
  List<String> selectedImagePaths = [];
  List<OcrTextWithPosition> _ocrResults = [];
  List<Rect> highlights = [];

  List<String> _searchResultImagePaths = [];
  List<List<Rect>> _searchResultHighlights = [];
  Dio dio = Dio(); // Create a Dio instance for API calls
  int contractId = 0; // Assuming you'll have a contract ID to fetch
  List<ImageProvider> contractImages = [];

  List<Rect> adjustHighlights(List<Rect> originalHighlights, double scale) {
    return originalHighlights.map((rect) {
      return Rect.fromLTRB(
        rect.left * scale,
        rect.top * scale,
        rect.right * scale,
        rect.bottom * scale,
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchContractImages(widget.contractId);
  }

  Future fetchContractImages(int contractId) async {
    try {
      var response =
          await dio.get('/rec/contract', queryParameters: {'id': contractId});
      var contractInformation = response.data;
      setState(() {
        contractImages = contractInformation.images
            .map((imageUrl) => NetworkImage(imageUrl))
            .toList();
      });
    } catch (e) {
      print("Error fetching contract images: $e");
      // Handle error gracefully, e.g., display an error message
    }
  }

  void _onSearch(String query) async {
    String searchQuery = query.toLowerCase();

    List<String> newSearchResultImagePaths = [];
    List<List<Rect>> newSearchResultHighlights = [];

    for (String path in selectedImagePaths) {
      List<OcrTextWithPosition> ocrResults = await extractTextFromImage(path);
      List<Rect> imageHighlights = [];
      bool found = false;

      for (var result in ocrResults) {
        if (result.text.toLowerCase().contains(searchQuery)) {
          //print("Found '${result.text}' at position: ${result.position}");
          imageHighlights.add(result.position);
          found = true;
        }
      }
      if (found) {
        newSearchResultImagePaths.add(path);
        newSearchResultHighlights.add(imageHighlights);
      }
    }
    setState(() {
      _searchResultImagePaths = newSearchResultImagePaths;
      _searchResultHighlights = newSearchResultHighlights;
    });
  }

  void handleImagePicked(String path) async {
    List<OcrTextWithPosition> ocrResults = await extractTextFromImage(path);
    setState(() {
      selectedImagePaths.add(path);
      _ocrResults.addAll(ocrResults);
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
      body: SingleChildScrollView(
        child: Center(
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
                    controller: _controller,
                    decoration: const InputDecoration(
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
                    onSubmitted: (value) => _onSearch(value),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //PickImage(onImagePicked: handleImagePicked),
              _buildContractImageGallery(contractImages),
              ..._buildSearchResults(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSearchResults() {
    List<Widget> searchResultWidgets = [];
    for (int i = 0; i < _searchResultImagePaths.length; i++) {
      searchResultWidgets.add(buildSearchResults(
          _searchResultImagePaths[i], _searchResultHighlights[i]));
    }
    return searchResultWidgets;
  }

  Widget buildSearchResults(String imagePath, List<Rect> highlights) {
    return FutureBuilder<Size>(
      future: getImageSize(imagePath),
      builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Size originalSize = snapshot.data!;
          double scale =
              min(400 / originalSize.width, 500 / originalSize.height);
          List<Rect> adjustedHighlights = adjustHighlights(highlights, scale);

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Stack(
              children: <Widget>[
                Image.file(
                  File(imagePath),
                  width: originalSize.width * scale,
                  height: originalSize.height * scale,
                ),
                Positioned.fill(
                  child: CustomPaint(
                    size: Size(originalSize.width * scale,
                        originalSize.height * scale),
                    painter: HighlightPainter(highlights: adjustedHighlights),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<Size> getImageSize(String imagePath) async {
    Completer<Size> completer = Completer();
    Image image = Image.file(File(imagePath));
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        var myImage = imageInfo.image;
        Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      }),
    );
    return completer.future;
  }
}

Widget _buildContractImageGallery(List<ImageProvider> images) {
  return Container(
    height: 200, // adjust height as needed
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    ),
  );
}
