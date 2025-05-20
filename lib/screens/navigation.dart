import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/main.dart';
import 'package:derma_ai/screens/saved_results_page.dart';
import 'package:derma_ai/screens/home_screen.dart';
import 'package:derma_ai/widgets/nav_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:derma_ai/screens/about/about_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final isMediumScreen = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      backgroundColor: kPrimaryDark,
      extendBody: true,
      body: Row(
        children: [
          // Side Navigation for web and larger screens
          if (!isSmallScreen)
            Container(
              width: isMediumScreen ? 80 : 100,
              decoration: BoxDecoration(
                color: ksecondaryDark,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    isSelected: selectedScreen == 0,
                    onTap: () => setState(() => selectedScreen = 0),
                  ),
                  const SizedBox(height: 20),
                  _buildNavItem(
                    icon: Icons.camera,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildNavItem(
                    icon: Icons.menu_book_rounded,
                    isSelected: selectedScreen == 2,
                    onTap: () => setState(() => selectedScreen = 2),
                  ),
                  const SizedBox(height: 20),
                  _buildNavItem(
                    icon: Icons.info_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          // Main Content
          Expanded(
            child: Stack(
              children: [
                buildScreen(),
                // Bottom Navigation for mobile
                if (isSmallScreen)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: ksecondaryDark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: NavCard(
                              icon: const Icon(Icons.home),
                              isSelected: selectedScreen == 0,
                              onTapCallback: () {
                                setState(() {
                                  selectedScreen = 0;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: NavCard(
                              icon: const Icon(
                                Icons.camera,
                                color: Colors.black,
                              ),
                              onTapCallback: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scanner(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: NavCard(
                              icon: const Icon(Icons.menu_book_rounded),
                              isSelected: selectedScreen == 2,
                              onTapCallback: () {
                                setState(() {
                                  selectedScreen = 2;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: NavCard(
                              icon: const Icon(Icons.info_outline),
                              onTapCallback: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
          size: 28,
        ),
      ),
    );
  }

  buildScreen() {
    switch (selectedScreen) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Scaffold(
          body: Center(
            child: Text(
              'Camera',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      case 2:
        return const SavedResultPage();
      default:
        return const Center(
          child: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }
}
