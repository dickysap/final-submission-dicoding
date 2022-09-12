import 'package:makan_makan/Api/models/element.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblShoppingCart = 'shopping_cart';

  Future<Database> _initilizaeDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute(''' CREATE TABLE $_tblShoppingCart(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DOUBLE
          )''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initilizaeDB();
    return _database;
  }

  Future<void> insertShoppingCart(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblShoppingCart, restaurant.toJson());
  }

  Future<List<Restaurant>> getShoppingCart() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblShoppingCart);
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getShoppingCartById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db!.query(_tblShoppingCart, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeShoppingCart(String id) async {
    final db = await database;

    await db!.delete(_tblShoppingCart, where: 'id = ?', whereArgs: [id]);
  }
}
