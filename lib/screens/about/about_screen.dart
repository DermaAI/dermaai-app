import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About Developers',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sora',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const Text(
                'DermaAI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sora',
                ),
              ),
              const SizedBox(height: 15),
              _buildInfoCard(
                title: 'About',
                content:
                    'DermaAI is an innovative application developed during a hackathon by Anas Ansari and Hamza Khan during their 2nd year of college. The app leverages artificial intelligence to make skin health assessment more accessible through technology.',
              ),
              const SizedBox(height: 30),
              _buildDeveloperSection(
                name: 'Anas Ansari',
                role: 'AI/ML Engineer & Flutter Developer',
                bio: 'Leverages expertise in AI/ML to develop and optimize machine learning solutions, with a focus on deploying scalable applications using frameworks like Flask and advanced language models such as BERT and LLM. Also a skilled Flutter developer currently pursuing BTech in Computer Engineering at Vishwakarma Institute of Information Technology.',
                github: 'https://github.com/AnasAnsari',
                linkedin: 'https://linkedin.com/in/anasansari',
                context: context,
              ),
              const SizedBox(height: 30),
              _buildDeveloperSection(
                name: 'Hamza Khan',
                role: 'UI/UX Designer & Flutter Developer',
                bio: 'Mobile UI/UX Designer and Flutter developer with 2 years of experience. Dedicated to creating creative digital solutions as user-friendly products. Expertise in designing visually appealing and intuitive UI/UX for Mobile and Web Applications with global freelance experience.',
                github: 'https://github.com/HamzaKhan07',
                linkedin: 'https://linkedin.com/in/hamzakhan07',
                website: 'https://hamzakhan07.netlify.app/',
                behance: 'https://behance.net/hamzakhan07',
                playstore: 'https://play.google.com/store/apps/developer?id=Dashing+Developer',
                context: context,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                title: 'Version',
                content: '1.0.0',
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '© 2024 DermaAI. All rights reserved.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),))
        ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ksecondaryDark,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: kPurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sora',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Sora',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperSection({
    required String name,
    required String role,
    required String bio,
    required String github,
    required String linkedin,
    String? website,
    String? behance,
    String? playstore,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ksecondaryDark,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: kPurple,
                child: Text(
                  name.substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sora',
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        color: kPurple,
                        fontSize: 16,
                        fontFamily: 'Sora',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            bio,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Sora',
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildSocialButton(
                icon: Icons.code,
                label: 'GitHub',
                url: github,
                context: context,
              ),
              _buildSocialButton(
                icon: Icons.work,
                label: 'LinkedIn',
                url: linkedin,
                context: context,
              ),
              if (website != null)
                _buildSocialButton(
                  icon: Icons.language,
                  label: 'Website',
                  url: website,
                  context: context,
                ),
              if (behance != null)
                _buildSocialButton(
                  icon: Icons.brush,
                  label: 'Behance',
                  url: behance,
                  context: context,
                ),
              if (playstore != null)
                _buildSocialButton(
                  icon: Icons.play_arrow,
                  label: 'Play Store',
                  url: playstore,
                  context: context,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
    required BuildContext context,
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
}