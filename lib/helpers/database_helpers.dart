import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableHabits = 'habits';
final String columnId = '_id';
final String columnHabit = 'habit';
final String columnDescription = 'description';
final String columnTime = 'time';
final String columnActive = 'active';

// data model class
// class HabitsList {
//   final List<Habit> habitsList;
//
//   HabitsList({
//     this.habitsList,
//   });
//
//   factory HabitsList.fromJson(List<dynamic> parsedJson) {
//
//     List<HabitsList> habits = new List<HabitsList>();
//     habits = parsedJson.map((i)=>HabitsList.fromJson(i)).toList();
//
//     return new HabitsList(
//         habitsList: habits
//     );
//   }
// }

class Habit {

  int id;
  String habit;
  String description;
  String time;
  bool active;

  Habit(this.id, this.habit, this.description, this.time, this.active);


  Habit.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.habit = map[columnHabit];
    this.description = map[columnDescription];
    this.time = map[columnTime];
    this.active = map[columnActive];
  }
  Habit.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    habit = json['habit'];
    description = json['description'];
    time = json['time'];
    active = json['active'];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnHabit: habit,
      columnDescription: description,
      columnTime: time,
      columnActive: active,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }


  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableHabits (
                $columnId INTEGER PRIMARY KEY,
                $columnHabit TEXT NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnTime TIME NOT NULL,
                $columnActive BOOL NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(Habit habit) async {
    Database db = await database;
    int id = await db.insert(tableHabits, habit.toMap());
    return id;
  }

  Future<Habit> queryHabit(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableHabits,
        columns: [
          columnId,
          columnHabit,
          columnDescription,
          columnTime,
          columnActive
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Habit.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Habit>> queryAll() async {
    print("yo");
    Database db = await DatabaseHelper.instance.database;

    // get all rows
    var allResults = await db.query(tableHabits);
    int count = allResults.length;
    print(count);
    List<Habit> habitList = List<Habit>();
    // For loop to create a 'habit List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      habitList.add(Habit.fromMap(allResults[i]));
    }

    return habitList;
    // return all_results;
  }

}
