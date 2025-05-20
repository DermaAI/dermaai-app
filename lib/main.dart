import 'dart:io';
import 'package:camera/camera.dart';
import 'package:derma_ai/utils/image_compressor.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/screens/results/cancer_prediction.dart';
import 'package:derma_ai/screens/results/main_prediction.dart';
import 'package:derma_ai/utils/wrapper.dart';
import 'package:derma_ai/screens/about/about_screen.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(const SkinApp());
}

class SkinApp extends StatelessWidget {
  const SkinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Sora",
          //Dark Theme
          brightness: Brightness.dark,
          useMaterial3: true),
      home: const Wrapper(),
    );
  }
}

/// Scanner is the Main Application.
class Scanner extends StatefulWidget {
  final int? model;

  /// Default Constructor
  const Scanner({Key? key, this.model}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  CameraController? controller;
  bool isFlashOn = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      index = widget.model!;
    }
    if (!kIsWeb && _cameras != null && _cameras!.isNotEmpty) {
      controller = CameraController(_cameras![0], ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          print('Camera error: ${e.code}');
        }
      });
      isFlashOn = controller!.value.flashMode == FlashMode.torch;
    }
  }

  @override
  void dispose() {
    if (!kIsWeb && controller != null) {
      controller!.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File image = File(pickedFile.path);
    final compressedImage = await getCompressedImage(image);
    if (compressedImage != null) {
      image = compressedImage;
    }

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => index == 0
            ? MainPrediction(image: image)
            : CancerPredictionPage(image: image),
      ),
    );
  }

  Future<void> _takePicture() async {
    if (kIsWeb || controller == null) return;

    try {
      final XFile file = await controller!.takePicture();
      File image = File(file.path);
      final compressedImage = await getCompressedImage(image);
      if (compressedImage != null) {
        image = compressedImage;
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => index == 0
              ? MainPrediction(image: image)
              : CancerPredictionPage(image: image),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (controller == null || !controller!.value.isInitialized)) {
      return const Center(child: CircularProgressIndicator());
    }

    if (kIsWeb) {
      // Web-friendly upload UI
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.upload_file, size: 80, color: Colors.white),
                const SizedBox(height: 24),
                const Text(
                  'Upload an image to analyze',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Select an image from your gallery',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.upload_file, color: Colors.black),
                  label: const Text(
                    'Upload Image',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildToggleButton(context),
              ],
            ),
          ),
        ),
      );
    }

    // Mobile: show camera preview and controls
    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(controller!),
            cameraOverlay(
              padding: 50,
              aspectRatio: 1,
              color: const Color(0x55000000),
            ),
            // Top bar
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Scanning for: ${index == 0 ? "Skin Disease" : "Skin Cancer"}',
                        style: const TextStyle(
                          fontFamily: 'Sora',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (controller != null)
                          IconButton(
                            onPressed: () {
                              if (isFlashOn) {
                                controller!.setFlashMode(FlashMode.off);
                                setState(() => isFlashOn = false);
                              } else {
                                controller!.setFlashMode(FlashMode.torch);
                                setState(() => isFlashOn = true);
                              }
                            },
                            icon: Icon(
                              isFlashOn ? Icons.flash_on : Icons.flash_off,
                              color: Colors.white,
                            ),
                          ),
                        IconButton(
                          icon: const Icon(Icons.info_outline, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AboutScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Upload from gallery button
            Positioned(
              bottom: 210,
              left: MediaQuery.of(context).size.width * 0.25,
              child: GestureDetector(
                onTap: _pickImageFromGallery,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image,
                        color: Color(0xFF313131),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Upload from Gallery',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          color: Color(0xFF313131),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Take picture button
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width * 0.41,
              child: SizedBox(
                width: 70,
                height: 70,
                child: TextButton(
                  onPressed: _takePicture,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Icon(Icons.camera, color: Colors.black, size: 30),
                ),
              ),
            ),
            // Toggle button
            Positioned(
              bottom: 20,
              left: 50,
              child: _buildToggleButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => index = 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: index == 0 ? kGreen : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    'Skin Disease',
                    style: TextStyle(
                      fontSize: 14,
                      color: index == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => index = 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: index == 1 ? kPurple : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    'Skin Cancer',
                    style: TextStyle(
                      fontSize: 14,
                      color: index == 1 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cameraOverlay(
      {required double padding,
      required double aspectRatio,
      required Color color}) {
    return LayoutBuilder(builder: (context, constraints) {
      double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
      double horizontalPadding;
      double verticalPadding;

      if (parentAspectRatio < aspectRatio) {
        horizontalPadding = padding;
        verticalPadding = (constraints.maxHeight -
                ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
            2;
      } else {
        verticalPadding = padding;
        horizontalPadding = (constraints.maxWidth -
                ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
            2;
      }
      return Stack(fit: StackFit.expand, children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.centerRight,
            child: Container(width: horizontalPadding, color: color)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    left: horizontalPadding, right: horizontalPadding),
                height: verticalPadding,
                color: color)),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
        )
      ]);
    });
  }
}
