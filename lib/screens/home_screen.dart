import 'package:derma_ai/screens/knowledge_page.dart';
import 'package:derma_ai/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/main.dart';
import 'package:derma_ai/screens/results/main_prediction.dart';
import 'package:derma_ai/utils/db_helpers.dart';
import 'package:derma_ai/utils/save_name.dart';
import 'package:derma_ai/widgets/cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  String name = '';

  void getName() {
    SaveName().getName().then((value) {
      setState(() {
        isLoading = false;
        name = value;
      });
    });
  }

  void setDatabase() {
    ResultModel.createDatabase().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
    //Initialize the database
    setDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryDark,
        body: SafeArea(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Hello, $name 👋',
                  style: TextStyle(
                      fontSize: getHeadingSize(context),
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //CARDS
              MainCard(
                image: 'images/detect-skin.png',
                title: 'Scan Prescription',
                subtitle:
                    'Instantly detect skin disease by uploading a picture of your skin.',
                avatarColor: korange,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scanner(
                        model: 0,
                      ),
                    ),
                  );
                },
              ),
              MainCard(
                image: 'images/check-severity.png',
                title: 'Scan Doctor Notes',
                subtitle:
                    'Instantly identify whether a mole is cancerous or non-cancerous.',
                avatarColor: kblue,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scanner(
                        model: 1,
                      ),
                    ),
                  );
                },
              ),
              MainCard(
                image: 'images/explore.png',
                title: 'Scan Lab Reports',
                subtitle: 'Explore various kinds of skin diseases.',
                avatarColor: kred,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KnowledgePage()));
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
