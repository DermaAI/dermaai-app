import 'dart:io';
import 'package:camera/camera.dart';
import 'package:derma_ai/utils/image_compressor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/screens/results/cancer_prediction.dart';
import 'package:derma_ai/screens/results/main_prediction.dart';
import 'package:derma_ai/utils/wrapper.dart';

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
  late CameraController controller;
  bool isFlashOn = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      index = widget.model!;
    }
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
    isFlashOn = controller.value.flashMode == FlashMode.torch;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggle() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Scaffold(
          body: Stack(fit: StackFit.expand, children: [
            CameraPreview(controller),
            cameraOverlay(
                padding: 50, aspectRatio: 1, color: const Color(0x55000000)),
            Positioned(
              top: 50,
              // left: MediaQuery.of(context).size.width * 0.22,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close)),
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Toggle flash light
                      if (isFlashOn) {
                        controller.setFlashMode(FlashMode.off);
                        setState(() {
                          isFlashOn = false;
                        });
                      } else {
                        controller.setFlashMode(FlashMode.torch);
                        setState(() {
                          isFlashOn = true;
                        });
                      }
                    },
                    icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
                  )
                ],
              ),
            ),

            //Upload from gallery button
            Positioned(
              bottom: 210,
              left: MediaQuery.of(context).size.width * 0.25,
              child: GestureDetector(
                onTap: () {
                  ImagePicker()
                      .pickImage(
                    source: ImageSource.gallery,
                  )
                      .then((pickedFile) async {
                    if (pickedFile == null) return;
                    File image = File(pickedFile.path);
                    //Compress the image
                    getCompressedImage(image).then((value) {
                      if (value != null) {
                        image = value;
                      }

                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPrediction(
                              image: image,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CancerPredictionPage(
                              image: image,
                            ),
                          ),
                        );
                      }
                    });
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Upload from Gallery',
                        style: TextStyle(
                            fontFamily: 'Sora',
                            color: Color(0xFF313131),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width * 0.41,
              child: SizedBox(
                width: 70,
                height: 70,
                child: TextButton(
                  onPressed: () {
                    //Take picture
                    controller.takePicture().then((XFile file) {
                      File image = File(file.path);
                      //Compress the image
                      getCompressedImage(image).then((value) {
                        if (value != null) {
                          image = value;
                        }

                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPrediction(
                                image: image,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CancerPredictionPage(
                                image: image,
                              ),
                            ),
                          );
                        }
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child:
                      const Icon(Icons.camera, color: Colors.black, size: 30),
                ),
              ),
            ),
            Positioned(bottom: 20, left: 50, child: buildToggleButton()),
          ]),
        ));
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

  buildToggleButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
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
                        fontSize: 14, color: index == 0 ? Colors.black : null),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: index == 1 ? kPurple : Colors.grey,
                ),
                child: const Center(
                  child: Text(
                    'Skin Cancer',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
