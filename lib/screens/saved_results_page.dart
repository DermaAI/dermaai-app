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
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getData();
            });
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Saved Results',
                      style: TextStyle(
                          fontSize: getHeadingSize(context),
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //Delete button
                  GestureDetector(
                    onTap: () async {
                      //Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete all results?'),
                            content: const Text(
                                'This action cannot be undone. Are you sure you want to delete all results?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  //Delete all results
                                  await ResultModel.deleteAll().then((value) {
                                    //Refresh the page
                                    setState(() {
                                      getData();
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ksecondaryDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.delete),
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
                            top: MediaQuery.of(context).size.height * 0.3),
                        child: const Center(
                          child: Text(
                            'Results will be saved here',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
              //CARDS
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
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