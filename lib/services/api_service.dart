import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  //To get skin disease prediction
  static Future getMainPrediction(String imagePath) async {
    print('Getting Prediction');
    const String apiUrl =
        'http://ec2-54-144-1-199.compute-1.amazonaws.com:8000/predict/main';
    //Using multipart request to send image to the server
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print(responseString);
    print('Got Prediction');
    return jsonDecode(responseString);
  }

  //To classify skin disease as benign or malignant
  static Future getCancerPrediction(String imagePath) async {
    print('Getting Prediction for Cancer');
    const String apiUrl =
        'http://ec2-54-144-1-199.compute-1.amazonaws.com:8000/predict/cancer';
    //Using multipart request to send image to the server
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print(responseString);
    print('Got Prediction for Cancer');
    return jsonDecode(responseString);
  }
}
