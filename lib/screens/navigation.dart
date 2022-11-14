import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/main.dart';
import 'package:derma_ai/screens/saved_results_page.dart';
import 'package:derma_ai/screens/home_screen.dart';
import 'package:derma_ai/widgets/nav_card.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      extendBody: true,
      body: Stack(
        children: [
          buildScreen(),
          //Floating Navigation Bar
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
                ],
              ),
            ),
          ),
        ],
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
