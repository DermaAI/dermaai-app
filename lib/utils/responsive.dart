import 'package:flutter/cupertino.dart';

double getHeadingSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width * 0.01;
  return width * 9;
}
