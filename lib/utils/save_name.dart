import 'package:shared_preferences/shared_preferences.dart';

class SaveName {
  //saved Name in Local
  void saveName(String name) {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => value.setString('name', name));
  }

  //get Saved name
  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? '';
  }

  //Stream to check whether name is entered or not
  Stream<bool> checkName() async* {
    final prefs = await SharedPreferences.getInstance();
    yield prefs.getString('name') != null;
  }

  //Delete name from local
  void deleteName() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) => value.remove('name'));
  }
}
