# flutter_native_ocr

A Flutter plugin that provides native OCR (Optical Character Recognition) capabilities using platform-specific frameworks.

## Features

- **iOS**: Native OCR using Apple's Vision framework
- **Android**: Native OCR using Google ML Kit Text Recognition v2 (v16.0.1)
- High accuracy text recognition on both platforms
- Support for multiple languages
- On-device processing (no internet required)
- Simple and easy-to-use API

## Requirements

### iOS
- iOS 13.0 or later
- Xcode 11 or later

### Android
- Android API level 21 (Android 5.0) or later
- Google Play Services (for ML Kit)
- Android SDK 35 or higher (for compilation)
- Java 11 or higher

### Flutter
- Flutter 3.3.0 or later

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_native_ocr: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Android Configuration

If you encounter build issues, ensure your Android project is configured with the following minimum requirements:

### In your `android/app/build.gradle`:

```gradle
android {
    compileSdk = 35  // Use 35 or higher
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11  // Use Java 11
        targetCompatibility = JavaVersion.VERSION_11
    }
    
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11
    }
    
    defaultConfig {
        minSdk = 21      // Minimum supported
        targetSdk = 35   // Should match compileSdk
    }
}
```

### Common Issues:
- **SDK Version Warning**: If you see warnings about plugin compatibility, use `compileSdk = 35`
- **Java Version**: ML Kit requires Java 11 or higher
- **NDK Version**: Use the latest NDK version for best compatibility

## Future Plans

This package supports both iOS and Android platforms. Future enhancements may include:
- Advanced OCR options (language hints, confidence scores)
- Support for more specialized text recognition models

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
- `UnsupportedError`: If called on unsupported platforms (only iOS and Android are supported)
- `PlatformException`: If there's an error during text recognition

## Supported Image Formats

### iOS
The plugin supports all image formats supported by UIImage, including:
- JPEG
- PNG
- HEIF/HEIC
- TIFF
- BMP
- GIF

### Android
The plugin supports all image formats supported by ML Kit, including:
- JPEG
- PNG
- BMP
- GIF
- WebP

## Platform Support

This plugin supports both **iOS** and **Android** platforms:
- **iOS**: Utilizes Apple's Vision framework for text recognition
- **Android**: Utilizes Google ML Kit Text Recognition v2 for text recognition

Both implementations provide on-device processing with no internet connection required.

## Privacy

This plugin processes images locally on the device:
- **iOS**: Uses Apple's Vision framework (on-device processing)
- **Android**: Uses Google ML Kit (on-device processing)

No data is sent to external servers on either platform.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.

