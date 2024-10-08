import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static const int version = 1; //-> mudar pra PROXIMA

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      path.join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        // CRIAR TABELA DO BANCO
      },
      version: version,
    );
  }

  Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await database();
    await db.insert(table, data);
  }

  Future<void> delete(String table, String where, List<Object?> whereArgs) async {
    final db = await database();
    await db.delete(table, where: where, whereArgs: whereArgs);
  }


  Future<List> find(String table, String where, List<Object?> whereArgs) async {
    final db = await database();

    final List<Map<String, dynamic>> result = await db.query(table, where: where, whereArgs: whereArgs);

    return result.toList();
  }

  Future<List> findAll(String table) async {
    final db = await database();

    final List<Map<String, dynamic>> result = await db.query(table);

    return result.toList();
  }


  Future<void> update(String table,Map<String, Object?> values, String where, List<Object?> whereArgs) async {
    final db = await database();
    await db.update(table, values, where: where, whereArgs: whereArgs);
  }


//     Fluttertoast.showToast(
//         msg: "Mensagem:$e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         textColor: Colors.white,
//         fontSize: 7.0);

}