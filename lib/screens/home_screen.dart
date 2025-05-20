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
import 'package:url_launcher/url_launcher.dart';

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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kPurple, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: kPurple, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Sora',
              ),
            ),
          ],
        ),
      ),
    );
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryDark,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildSocialButton(
            icon: Icons.code,
            label: 'GitHub',
            url: 'https://github.com/DermaAI/dermaai-app',
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 25 : 40,
                  vertical: isSmallScreen ? 20 : 30,
                ),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 40 : 60,
                    ),
                    child: Text(
                      'Hello, $name 👋',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 32,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Cards Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isSmallScreen ? 1 : (isMediumScreen ? 2 : 3),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.0,
                    children: [
                      MainCard(
                        image: 'images/detect-skin.png',
                        title: 'Scan Skin Disease',
                        subtitle: 'Instantly detect skin disease by uploading a picture of your skin.',
                        avatarColor: korange,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Scanner(model: 0),
                            ),
                          );
                        },
                      ),
                      MainCard(
                        image: 'images/check-severity.png',
                        title: 'Scan Cancerous Mole',
                        subtitle: 'Instantly identify whether a mole is cancerous or non-cancerous.',
                        avatarColor: kblue,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Scanner(model: 1),
                            ),
                          );
                        },
                      ),
                      MainCard(
                        image: 'images/explore.png',
                        title: 'Learn about diseases',
                        subtitle: 'Explore various kinds of skin diseases.',
                        avatarColor: kred,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KnowledgePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.medical_information, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Medical Disclaimer: This app is for informational purposes only and should not be used as a substitute for professional medical advice, diagnosis, or treatment.',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 100 : 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
