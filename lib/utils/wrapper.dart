import 'package:flutter/material.dart';
import 'package:derma_ai/screens/navigation.dart';
import 'package:derma_ai/screens/welcome_screen.dart';
import 'package:derma_ai/utils/save_name.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: SaveName().checkName(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return const Navigation();
          } else {
            return const WelcomeScreen();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
