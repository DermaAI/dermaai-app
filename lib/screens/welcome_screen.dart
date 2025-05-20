import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';
import 'package:derma_ai/utils/save_name.dart';
import 'package:derma_ai/utils/wrapper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 25 : 40,
                  vertical: isSmallScreen ? 20 : 30,
                ),
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Image.asset(
                        'images/icon.png',
                        fit: BoxFit.cover,
                        width: isSmallScreen ? 60 : 80,
                        height: isSmallScreen ? 60 : 80,
                      ),
                      SizedBox(width: isSmallScreen ? 15 : 20),
                      Text(
                        'DermaAI',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 32 : 40,
                          fontFamily: "LeckerliOne",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 40 : 60),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 40 : 60,
                    ),
                    child: Text(
                      'Enter your Name',
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
                  // TextField
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: isSmallScreen ? double.infinity : 500,
                    ),
                    child: TextFormField(
                      controller: controller,
                      maxLength: 12,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Rohit',
                        hintStyle: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          color: Colors.grey,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.blue),
                        ),
                        errorStyle: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 132, 0),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 255, 132, 0),
                          ),
                        ),
                        counterStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 50 : 60),
                  // Button
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isSmallScreen ? double.infinity : 500,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 16 : 20,
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            SaveName().saveName(controller.text);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Wrapper(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
