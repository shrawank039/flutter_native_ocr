# flutter_native_ocr

A Flutter plugin that provides native iOS OCR (Optical Character Recognition) capabilities using Apple's Vision framework.

## Features

- Native iOS OCR using Apple's Vision framework
- High accuracy text recognition
- Support for multiple languages
- Simple and easy-to-use API
- iOS only (utilizes platform-specific Vision framework)

## Requirements

- iOS 13.0 or later
- Xcode 11 or later
- Flutter 3.3.0 or later

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_native_ocr: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Future Plans

This package currently supports iOS only. Android support using Google ML Kit is planned for future releases, which may result in a package rename to `flutter_native_ocr` for better cross-platform representation.

## Usage

### Basic Usage

```dart
import 'package:flutter_native_ocr/flutter_native_ocr.dart';

// Create an instance
final flutterNativeOcr = FlutterNativeOcr();

// Recognize text from an image file
String imagePath = '/path/to/your/image.jpg';
try {
  String recognizedText = await flutterNativeOcr.recognizeText(imagePath);
  print('Recognized text: $recognizedText');
} catch (e) {
  print('Error: $e');
}
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_native_ocr/flutter_native_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  final _flutterNativeOcr = FlutterNativeOcr();
  final ImagePicker _picker = ImagePicker();
  String _recognizedText = '';
  File? _imageFile;

  Future<void> _pickAndRecognize() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });

      try {
        final text = await _flutterNativeOcr.recognizeText(image.path);
        setState(() {
          _recognizedText = text.isEmpty ? 'No text found' : text;
        });
      } catch (e) {
        setState(() {
          _recognizedText = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OCR Example')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndRecognize,
            child: Text('Pick Image & Recognize Text'),
          ),
          if (_imageFile != null) Image.file(_imageFile!),
          if (_recognizedText.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(_recognizedText),
            ),
        ],
      ),
    );
  }
}
```

## API Reference

### Methods

#### `recognizeText(String imagePath)`

Recognizes text from an image file.

**Parameters:**
- `imagePath` (String): The absolute path to the image file

**Returns:**
- `Future<String>`: The recognized text as a string. Returns empty string if no text is found.

**Throws:**
- `UnsupportedError`: If called on non-iOS platforms
- `PlatformException`: If there's an error during text recognition

## Supported Image Formats

The plugin supports all image formats supported by UIImage, including:
- JPEG
- PNG
- HEIF/HEIC
- TIFF
- BMP
- GIF

## Platform Support

This plugin is **iOS only** and utilizes Apple's Vision framework for text recognition. It will throw an `UnsupportedError` if used on other platforms.

## Privacy

This plugin processes images locally on the device using Apple's Vision framework. No data is sent to external servers.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.os

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

