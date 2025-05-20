import 'package:derma_ai/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/utils/db_helpers.dart';
import 'package:derma_ai/widgets/cards.dart';

class SavedResultPage extends StatefulWidget {
  const SavedResultPage({super.key});

  @override
  State<SavedResultPage> createState() => _SavedResultPageState();
}

class _SavedResultPageState extends State<SavedResultPage> {
  Future<List<ResultModel>>? _results;

  void getData() {
    _results = ResultModel.getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  getData();
                });
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 25 : 40,
                  vertical: isSmallScreen ? 20 : 30,
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 40 : 60,
                        ),
                        child: Text(
                          'Saved Results',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 32 : 40,
                            fontFamily: 'Sora',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Delete button
                      GestureDetector(
                        onTap: () => _showDeleteConfirmationDialog(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ksecondaryDark,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                          child: Icon(
                            Icons.delete,
                            size: isSmallScreen ? 24 : 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<ResultModel>>(
                    future: _results,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: Center(
                              child: Text(
                                'Results will be saved here',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 20 : 24,
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                        return GridView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isSmallScreen ? 1 : (isMediumScreen ? 2 : 3),
                            childAspectRatio: isSmallScreen ? 1.5 : 1.2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            ResultModel data = snapshot.data![index];
                            return ResultCard(
                              title: data.name,
                              confidence: data.confidence.toString(),
                              imagePath: data.imagePath,
                              date: data.timestamp,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: isSmallScreen ? 80 : 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kCardColor,
        title: Text(
          'Delete all results?',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This action cannot be undone. Are you sure you want to delete all results?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ResultModel.deleteAll().then((value) {
                setState(() {
                  getData();
                });
                Navigator.pop(context);
              });
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}


// const HistoryCard(
//               image:
//                   'https://static-bebeautiful-in.unileverservices.com/makeup-tips-for-girls-with-acne-prone-skin_mobilehome.jpg',
//               title: 'dermatofibroma ',
//               date: '12 May 2021',
//               confidence: "99.9",
//             ),
//             const HistoryCard(
//               image:
//                   'https://as2.ftcdn.net/v2/jpg/00/80/57/07/1000_F_80570762_3UfSGQNhZncgJ0rDx4VnpMKfJ4mx7oO0.jpg',
//               title: 'basal cell carcinoma',
//               date: '12 May 2021',
//               confidence: "99.9",
//             ),
//             const HistoryCard(
//               image:
//                   'https://as1.ftcdn.net/v2/jpg/02/61/56/14/1000_F_261561462_pNzQCOhDGEOPQIK0JJBWepV8MLzOTi09.jpg',
//               title: 'pigmented benign keratosis',
//               date: '12 May 2021',
//               confidence: "99.9",
//             ),