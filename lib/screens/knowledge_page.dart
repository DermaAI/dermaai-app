import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/models/knowlege_model.dart';
import 'package:derma_ai/widgets/knowledge_screen.dart';
import 'package:flutter/material.dart';

class KnowledgePage extends StatelessWidget {
  const KnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 40,
              vertical: isSmallScreen ? 10 : 20,
            ),
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 10 : 20,
                  vertical: isSmallScreen ? 5 : 10,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: isSmallScreen ? 24 : 28,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              if (!isSmallScreen)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Skin Disease Knowledge Base',
                    style: TextStyle(
                      fontSize: isMediumScreen ? 32 : 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmallScreen ? 1 : (isMediumScreen ? 2 : 3),
                  childAspectRatio: isSmallScreen ? 2.5 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: knowledgeList.length,
                itemBuilder: (context, index) => buildCard(context, index, isSmallScreen),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int index, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KnowledgeScreen(
              knowledge: knowledgeList[index],
            ),
          ),
        );
      },
      child: Container(
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
        padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
        child: Row(
          children: [
            // Image
            Container(
              height: isSmallScreen ? 80 : 100,
              width: isSmallScreen ? 80 : 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(knowledgeList[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 20 : 25),
            // Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    knowledgeList[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 15),
                  Text(
                    '${knowledgeList[index].shortDescription.substring(0, 70)}...',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: isSmallScreen ? 14 : 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//