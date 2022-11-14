import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/models/knowlege_model.dart';
import 'package:flutter/material.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({super.key, required this.knowledge});
  final Knowledge knowledge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SafeArea(
            child: Text(" ${knowledge.title}",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[
                          Colors.white,
                          Colors.white,
                          //add more color here.
                        ],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)))),
          ),
          const SizedBox(height: 15),
          customCard("Symptoms", knowledge.symtomps),
          const SizedBox(height: 12),
          customCard("Causes", knowledge.causes),
          const SizedBox(height: 12),
          customCard("Treatment", knowledge.treatment),
          const SizedBox(height: 12),
          customCard("Prevention", knowledge.prevention)
        ],
      ),
    );
  }
}

Widget customCard(String heading, String content) {
  return Card(
    // shadowColor: Color.fromARGB(255, 0, 255, 255),
    // elevation: 8,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Container(
      // decoration: const BoxDecoration(
      //   // gradient: LinearGradient(
      //   //   colors: [Colors.pinkAccent, Colors.white],
      //   //   begin: Alignment.topCenter,
      //   //   end: Alignment.bottomCenter,
      //   // ),
      // ),
      color: kCardColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            content,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
