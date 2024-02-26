import 'dart:math';
import 'dart:ui';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrTextWithPosition {
  final String text;
  final Rect position;

  OcrTextWithPosition(this.text, this.position);
}

Future<List<OcrTextWithPosition>> extractTextFromImage(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final textRecognizer = TextRecognizer();
  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

  List<OcrTextWithPosition> results= [];

  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      for (TextElement word in line.elements) {
        if (word.text != null && word.boundingBox != null) {
          results.add(OcrTextWithPosition(word.text, word.boundingBox!));
        }
      }
    }
  }

  textRecognizer.close();
  return results;
}
