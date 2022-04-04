import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class Conection{
  Future<Database> getConection() async{
    return openDatabase(
      join(await getDatabasesPath(), "TADSBANCO"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE alunos (id INTEGER PRIMARY KEY, nome TEXT, matricula TEXT, dataNasc TEXT)");
      },
      version: 1,
    );
  }

  Future<void> criarTabela() async {
    final db = await getConection();
    db.execute(
        "CREATE TABLE IF NOT EXISTS alunos (id INTEGER PRIMARY KEY, nome TEXT, matricula TEXT, dataNasc TEXT");
  }

  Future<void> recriarTabela() async {
    final db = await getConection();
    await db.execute("DROP TABLE IF EXISTS alunos");
    await db.execute(
        "CREATE TABLE alunos (id INTEGER PRIMARY KEY, nome TEXT, matricula TEXT, dataNasc TEXT");
  }

}
