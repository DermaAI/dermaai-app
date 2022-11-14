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
    final width = MediaQuery.of(context).size.width * 0.01;
    final height = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      backgroundColor: kPrimaryDark,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Image.asset(
                    'images/icon.png',
                    fit: BoxFit.cover,
                    width: width * 30,
                    height: width * 30,
                  ),
                  SizedBox(
                    width: width * 8,
                  ),
                  Text(
                    'DermaAI',
                    style: TextStyle(
                      fontSize: width * 9,
                      fontFamily: "LeckerliOne",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Enter your Name',
                  style: TextStyle(
                      fontSize: width * 9,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //TEXTFIELD
              TextFormField(
                controller: controller,
                maxLength: 12,
                style: TextStyle(fontSize: width * 5),
                decoration: InputDecoration(
                  hintText: 'Rohit',
                  hintStyle: TextStyle(fontSize: width * 5),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                  ),
                  errorStyle: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 255, 132, 0)),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromARGB(255, 255, 132, 0)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              //BUTTON
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: height * 1.5)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SaveName().saveName(controller.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Wrapper()));
                  }
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: width * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
