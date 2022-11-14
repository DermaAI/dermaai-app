import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ResultModel {
  final int id;
  final String type;
  final String name;
  final String imagePath;
  final double confidence;
  final String timestamp;
  static late Database database;

  ResultModel({
    required this.id,
    required this.type,
    required this.name,
    required this.imagePath,
    required this.confidence,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'imagePath': imagePath,
      'confidence': confidence,
      'timestamp': timestamp,
    };
  }

  //toString method
  @override
  String toString() {
    return 'ResultModel(id: $id, type: $type, name: $name, imagePath: $imagePath, confidence: $confidence, timestamp: $timestamp)';
  }

  static Future<void> createDatabase() async {
    print('creation started');
    database = await openDatabase(
      join(await getDatabasesPath(), 'results_database'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          'CREATE TABLE IF NOT EXISTS results(ID INTEGER PRIMARY KEY, Name TEXT, ImagePath TEXT, Confidence REAL, Timestamp TEXT)',
        );
      },
      version: 1,
    );
    print('creation completed');
  }

  Future<int> insertData() async {
    print('insertion started');
    int resultID = -1;

    final db =
        await openDatabase(join(await getDatabasesPath(), 'results_database'));
    print(db.isOpen);

    await db.transaction((txn) async {
      resultID = await txn.rawInsert(
          'INSERT INTO results(ID, Name, ImagePath, Confidence, Timestamp) VALUES(?, ?, ?, ?, ?)',
          [id, name, imagePath, confidence, timestamp]);
      print('inserted2: $id');
    });
    print('insertion completed');
    db.close();

    return id;
  }

  static Future<List<ResultModel>> getData() async {
    // Get a reference to the database.
    final db =
        await openDatabase(join(await getDatabasesPath(), 'results_database'));
    print(db.isOpen);
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('results');
    print(maps.length);
    print(maps);
    db.close();
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ResultModel(
        id: maps[i]['ID'],
        type: maps[i]['Type'],
        name: maps[i]['Name'],
        imagePath: maps[i]['ImagePath'],
        confidence: maps[i]['Confidence'],
        timestamp: maps[i]['Timestamp'],
      );
    });
  }

  static Future<void> deleteAll() async {
    print('deletion std');
    final db =
        await openDatabase(join(await getDatabasesPath(), 'results_database'));
    print(db.isOpen);

    //delete all rows
    int count = await db.delete('results');
    print('deleted $count rows');

    print('deletion completed');
    db.close();
  }
}
