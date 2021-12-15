import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String resultadoTable = "resultadoTable";
final String idColumn = "idColumn";
final String valor1Column = "valor1Column";
final String valor2Column = "valor2Column";
final String operatorColumn = "operatorColumn";
final String vTotalColumn = "vTotalColumn";

class ArmazenaConta {
  static final ArmazenaConta _instance = ArmazenaConta.internal();

  factory ArmazenaConta() => _instance;

  ArmazenaConta.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "historico.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $resultadoTable($idColumn INTEGER PRIMARY KEY, $valor1Column TEXT, $valor2Column TEXT,"
          "$operatorColumn TEXT, $vTotalColumn TEXT)");
    });
  }

  Future<Resultado> saveResultado(Resultado resultado) async {
    Database dbArmazena = await db;
    resultado.id = await dbArmazena.insert(resultadoTable, resultado.toMap());
    return resultado;
  }

  Future<Resultado> getResultado(int id) async {
    Database dbArmazena = await db;
    List<Map> maps = await dbArmazena.query(resultadoTable,
        columns: [
          idColumn,
          valor1Column,
          valor2Column,
          operatorColumn,
          vTotalColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Resultado.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteResultado(int id) async {
    Database dbArmazena = await db;
    return await dbArmazena
        .delete(resultadoTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  /*Future<List> deleteAll() async {
    ArmazenaConta helper = ArmazenaConta();
    Database dbArmazena = await db;
    helper.getAllResultados();
    dbArmazena.rawDelete("DELETE FROM $resultadoTable");
  }*/

  Future<List> getAllResultados() async {
    Database dbArmazena = await db;
    List listMap = await dbArmazena.rawQuery("SELECT * FROM $resultadoTable");
    List<Resultado> listResultados = List();
    for (Map m in listMap) {
      listResultados.add(Resultado.fromMap(m));
    }
    return listResultados;
  }

  Future<int> getNumber() async {
    Database dbArmazena = await db;
    return Sqflite.firstIntValue(
        await dbArmazena.rawQuery("SELECT COUNT(*) FROM $resultadoTable"));
  }

  Future close() async {
    Database dbArmazena = await db;
    dbArmazena.close();
  }
}

class Resultado {
  int id;
  String valor1;
  String valor2;
  String operator;
  String vTotal;

  Resultado();

  Resultado.fromMap(Map map) {
    id = map[idColumn];
    valor1 = map[valor1Column];
    valor2 = map[valor2Column];
    operator = map[operatorColumn];
    vTotal = map[vTotalColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valor1Column: valor1,
      valor2Column: valor2,
      operatorColumn: operator,
      vTotalColumn: vTotal,
    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Resultado(id: $id, valor1: $valor1, valor2: $valor2, operator: $operator, vTotal: $vTotal)";
  }
}
