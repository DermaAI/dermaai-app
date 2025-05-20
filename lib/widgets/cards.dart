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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: isSmallScreen ? 20 : 30),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 25 : 30,
          vertical: isSmallScreen ? 24 : 30,
        ),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: isSmallScreen ? 32 : 40,
                  backgroundColor: avatarColor,
                  child: Container(
                    padding: EdgeInsets.all(isSmallScreen ? 14 : 18),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 20 : 25),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: isSmallScreen ? 25 : 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 20 : 25),
            Flexible(
              child: Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  height: 1.4,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 25 : 30),
      width: double.infinity,
      height: isSmallScreen 
          ? MediaQuery.of(context).size.height * 0.35
          : MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        height: isSmallScreen ? 118 : 150,
                      ),
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 30 : 40),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 5 : 10,
                        vertical: isSmallScreen ? 10 : 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Confidence',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 113, 113, 113),
                              fontFamily: 'Sora',
                              fontWeight: FontWeight.w600,
                              fontSize: isSmallScreen ? 16 : 18,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${confidence.substring(0, 5)}%',
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  color: Colors.black,
                                  fontSize: isSmallScreen ? 28 : 32,
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
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 15 : 25,
                vertical: isSmallScreen ? 20 : 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Sora',
                            fontSize: isSmallScreen ? 25 : 28,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 10 : 15),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String name = prefs.getString('name') ?? 'User';
                          await generatePdf(name, title, confidence, File(imagePath), date);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 22 : 25,
                            vertical: isSmallScreen ? 20 : 22,
                          ),
                          decoration: BoxDecoration(
                            color: kblue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.summarize,
                            size: isSmallScreen ? 24 : 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 25),
                  Text(
                    getDateFromTimestamp(date),
                    style: TextStyle(
                      fontFamily: 'Sora',
                      color: Colors.grey,
                      fontSize: isSmallScreen ? 16 : 18,
                    ),
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
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

