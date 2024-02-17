import 'package:flutter/material.dart';
import 'dart:io';

//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class PhotoGallery extends StatefulWidget {
  final String searchKeyword;
  final List<String> imagePaths;

  PhotoGallery({Key? key, this.searchKeyword = '', required this.imagePaths})
      : super(key: key);

  State<PhotoGallery> createState() => _PhotoGalleryState();
}

@override
class _PhotoGalleryState extends State<PhotoGallery> {
  /*final List<String> thumbnailUrls = [
    'assets/images/ex1.jpg',
    'assets/images/ex2.jpg',
    'assets/images/ex3.jpg',
  ];*/

  int shownindex = 0;
  bool isKeywordFound = false;
  List<Rect> textRects = [];

  @override
  void initState() {
    super.initState();
    if (widget.searchKeyword.isNotEmpty) {
      performSearch(widget.searchKeyword);
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchKeyword != oldWidget.searchKeyword) {
      // 검색 키워드 변경
      print('bbbbbb');
      print(widget.searchKeyword);
      performSearch(widget.searchKeyword);
    }
  }

  void Tapped(index) {
    setState(() {
      shownindex = index;
    });
    //  performSearch(widget.searchKeyword);
  }

  Future<void> performSearch(String query) async {
    if (query.isEmpty) return;

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    for (String imagePath in widget.imagePaths) {
      final File imageFile = File(imagePath);
      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      bool keywordFound = false;
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          if (line.text.contains(query)) {
            keywordFound = true;
            textRects.add(line.boundingBox);
            print('aaaaaa');
            print(line.boundingBox);
            break;
          }
        }
        if (keywordFound) break;
      }

      if (keywordFound) {
        if (mounted) {
          setState(() {
            isKeywordFound = true;
            shownindex = widget.imagePaths.indexOf(imagePath);
          });
        }
        print("$imagePath에서 '$query' 키워드를 찾았습니다.");
        break;
      }
    }

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: Column(children: [
        Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: isKeywordFound
                  ? CustomPaint(
                      painter: TextHighlightPainter(textRects),
                      // 여기서 textRects는 OCR에서 인식한 텍스트의 위치를 나타내는 Rect의 리스트입니다.
                      child: Image.file(
                        File(widget.imagePaths[shownindex]),
                        width: 400,
                        height: 500,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.file(
                      File(widget.imagePaths[shownindex]), // Image.file 사용
                      width: 400,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
            ),
            /*
              child: Image.asset(
                thumbnailUrls[shownindex],
                width: 400,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.link, color: Colors.white),
              ),
            )*/
          ],
        ),
        /*
        Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: thumbnailUrls.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Tapped(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      thumbnailUrls[index],
                      width: 60, // Adjust the width as needed
                      height: 80, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          ),
        ),
     */
      ]),
    );
  }
}

// CustomPainter를 상속받는 TextHighlightPainter 클래스
class TextHighlightPainter extends CustomPainter {
  final List<Rect> textRects;

  TextHighlightPainter(this.textRects);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // 리스트에 있는 모든 Rect를 순회하며 캔버스에 그림
    for (var rect in textRects) {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // CustomPainter가 다시 그려야 하는지 여부를 결정
    return true;
  }
}
