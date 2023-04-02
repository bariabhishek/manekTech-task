import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/data/local_data_model/cart_item_model.dart';


class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cart.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE cart_item_table(id INTEGER PRIMARY KEY , title TEXT NOT NULL,description TEXT NULL,slug TEXT NULL,status TEXT NULL,created_at TEXT NULL, price INTEGER NOT NULL, featured_image TEXT NULL)",
        );
      },
    );
  }
// insert data
  Future<int> insertCartItem(List<CartProductItemData> planets) async {
    int result = 0;
    final Database db = await initializedDB();
    for (var planet in planets) {
      result = await db.insert('cart_item_table', planet.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }



    return result;
  }

// retrieve data
  Future<List<CartProductItemData>> retrieveCartItem() async {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('cart_item_table');
    return queryResult.map((e) => CartProductItemData.fromJson(e)).toList();
  }

// delete user
  Future<void> deleteCartItem(int id) async {
    final db = await initializedDB();
    await db.delete(
      'cart_item_table',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
