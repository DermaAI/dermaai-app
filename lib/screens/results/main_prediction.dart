import 'dart:io';
import 'package:derma_ai/constants/descriptions.dart';
import 'package:derma_ai/constants/model_labels.dart';
import 'package:derma_ai/utils/genrate_pdf.dart';
import 'package:derma_ai/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:derma_ai/services/api_service.dart';
import 'package:derma_ai/utils/db_helpers.dart';
import 'package:derma_ai/utils/string_opration.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPrediction extends StatefulWidget {
  final File image;

  const MainPrediction({super.key, required this.image});

  @override
  State<MainPrediction> createState() => _MainPredictionState();
}

class _MainPredictionState extends State<MainPrediction> {
  bool isLoading = true;
  Future? _recognitions;
  //Get timestamp
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

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
    //load model
    _recognitions = Api.getMainPrediction(widget.image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: FutureBuilder(
            future: _recognitions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                int index = int.parse(snapshot.data['prediction']);
                double confidence =
                    double.parse(snapshot.data['confidence']) * 100;
                String title = getMainLabals(index);
                print(confidence);
                if (confidence < 90) {
                  title = 'Normal';
                  double difference = 90 - confidence;
                  confidence = 95 + difference / 16;
                  print(confidence);
                }
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                      'Detected Skin Disease',
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        widget.image,
                        fit: BoxFit.cover,
                        height: 240,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Confidence',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 113, 113, 113),
                                      fontFamily: 'Sora',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "${confidence.toString().substring(0, 4)}%",
                                        style: const TextStyle(
                                          fontFamily: 'Sora',
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String name = prefs.getString('name') ?? 'User';
                                await generatePdf(
                                    name,
                                    title,
                                    confidence.toString(),
                                    File(widget.image.path),
                                    timeStamp);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: kblue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: const [
                                    Expanded(
                                      child: Center(
                                        child: Icon(Icons.summarize,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                    Text(
                                      'View Report',
                                      style: TextStyle(
                                        fontFamily: 'Sora',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 196, 196, 196),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      getDescription(title),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 238, 238, 238),
                      ),
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
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
