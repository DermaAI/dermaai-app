import 'dart:io';

import 'package:derma_ai/utils/genrate_pdf.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/utils/string_opration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.avatarColor,
    this.onTap,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final Color avatarColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: avatarColor,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Sora',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  const ResultCard({
    Key? key,
    required this.confidence,
    required this.title,
    required this.date,
    required this.imagePath,
  }) : super(key: key);

  final String confidence;
  final String title;
  final String date;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        height: 118,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
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
                                '${confidence.substring(0, 5)}%',
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
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Pigmented Benign Kartosis',
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          //get name from shared preferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String name = prefs.getString('name') ?? 'User';

                          await generatePdf(
                              name, title, confidence, File(imagePath), date);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 20),
                          decoration: BoxDecoration(
                            color: kblue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(Icons.summarize),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    getDateFromTimestamp(date),
                    style: const TextStyle(
                        fontFamily: 'Sora', color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getDateFromTimestamp(String date) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
