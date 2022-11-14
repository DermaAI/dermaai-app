import 'dart:io';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/constants/model_labels.dart';
import 'package:derma_ai/services/api_service.dart';
import 'package:derma_ai/utils/db_helpers.dart';
import 'package:derma_ai/utils/genrate_pdf.dart';
import 'package:derma_ai/utils/responsive.dart';
import 'package:derma_ai/utils/string_opration.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancerPredictionPage extends StatefulWidget {
  final File image;

  const CancerPredictionPage({super.key, required this.image});

  @override
  State<CancerPredictionPage> createState() => _CancerPredictionPageState();
}

class _CancerPredictionPageState extends State<CancerPredictionPage> {
  bool isLoading = true;
  Future? _model1;

  String timeStamp = "";

  Color getCardColor(String name) {
    if (name == 'malignant') {
      return const Color(0xFFE64A5E);
    } else if (name == 'benign') {
      return const Color.fromARGB(255, 255, 170, 0);
    } else {
      return const Color(0xFF00EB6C);
    }
  }

  Color getForeIndicatorColor(String name) {
    if (name == 'malignant') {
      return const Color(0xFF6C000E);
    } else if (name == 'benign') {
      return const Color(0xFFFFE500);
    } else {
      return const Color(0xFF007837);
    }
  }

  Color getBackIndicatorColor(String name) {
    if (name == 'malignant') {
      return const Color(0xFFD0001B);
    } else if (name == 'benign') {
      return const Color(0xFFFFF9C9);
    } else {
      return const Color(0xFF00CC5E);
    }
  }

  String? savedTimestamp;

  Future<String> saveImageInLocal() async {
    //get dir
    final directory = await getApplicationDocumentsDirectory();
    //get path
    final path = directory.path;
    //get image
    final String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //get file
    final file = File('$path/$imageName.jpg');
    //save image
    await widget.image.copy(file.path);
    return file.path;
  }

  Future<void> saveResult(String name, double confidence) async {
    setState(() {
      isLoading = true;
    });

    //save image in local storage using path_provider
    String savedImagePath = await saveImageInLocal();
    //Get timestamp
    //Define type of result
    String type = 'main';
    //save result in database
    await ResultModel(
            id: int.parse(timeStamp),
            type: type,
            name: name,
            imagePath: savedImagePath,
            confidence: confidence,
            timestamp: timeStamp)
        .insertData();

    setState(() {
      isLoading = false;
      savedTimestamp = timeStamp;
    });
  }

  @override
  void initState() {
    super.initState();
    _model1 = Api.getMainPrediction(widget.image.path);
    timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: FutureBuilder(
            future: _model1,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                int index = int.parse(snapshot.data['prediction']);
                double confidence =
                    double.parse(snapshot.data['confidence']) * 100;

                String title = getMainLabals(index);
                if (confidence < 90) {
                  title = 'Normal';
                  double difference = 90 - confidence;
                  confidence = 95 + difference / 16;
                  return buildScreen(title, confidence);
                } else {
                  return FutureBuilder(
                      future: Api.getCancerPrediction(widget.image.path),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int index = int.parse(snapshot.data['prediction']);
                          title = getCancerLabels(index);
                          double confidence =
                              double.parse(snapshot.data['confidence']) * 100;

                          return buildScreen(title, confidence);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget buildScreen(String title, double confidence) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            //save button
            GestureDetector(
              onTap: () async {
                if (savedTimestamp == null) {
                  await saveResult(title, confidence).then((value) {
                    //Show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Result saved successfully'),
                      ),
                    );
                  });
                } else {
                  //Show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Result already saved'),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ksecondaryDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(savedTimestamp != null
                    ? Icons.bookmark_added
                    : Icons.bookmark_border),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Detected Severity',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title.toTitleCase(),
          style: TextStyle(
              fontSize: getHeadingSize(context),
              color: Colors.white,
              fontWeight: FontWeight.w600),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 140),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.file(
              widget.image,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        //Circular Chart
        Container(
          height: 250,
          margin: const EdgeInsets.only(bottom: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: getCardColor(title),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  getType(title),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CircularPercentIndicator(
                radius: 72.0,
                lineWidth: 24.0,
                animation: true,
                percent: confidence / 100,
                center: Text(
                  '${confidence.toStringAsFixed(2)}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: getBackIndicatorColor(title),
                progressColor: getForeIndicatorColor(title),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String name = prefs.getString('name') ?? 'User';
            await generatePdf(name, title, confidence.toString(),
                File(widget.image.path), timeStamp);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: kblue,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Text(
                'View Report',
                style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        const Text(
          '*Note: This is just a prediction and not a medical diagnosis.',
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 196, 196, 196),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      ],
    );
  }

  String getType(String title) {
    if (title == 'malignant') {
      return 'Cancerous';
    } else if (title == 'benign') {
      return 'Non-Cancerous';
    } else {
      return 'Normal';
    }
  }
}
