import 'alunos.dart';
import 'package:sqflite/sqflite.dart';
import 'Conection.dart';
import 'dart:async';

class model {

  Future<List<alunos>> listarAlunos() async {
  final db = await Conection().getConection();
  final List<Map<String, dynamic>> resultado = await db.query('alunos');
  //await db.RawQuery("select * from alunos");
    return List.generate(resultado.length, (index) {
      return alunos(
          id: resultado[index]["id"],
          nome: resultado[index]["nome"],
          matricula: resultado[index]["matricula"],
          datNasc: resultado[index]["dataNasc"]);
    });
  }

  Future<void> inserirAluno(alunos z) async {
    final db = await Conection().getConection();
    await db.insert("alunos", z.criarMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("inserido");
  }

  Future<void> atualizarAluno(alunos z) async {
    final db = await Conection().getConection();
    await db.update("alunos", z.criarMap(), where: 'id = ?', whereArgs: [z.id]);
  }

  Future<void> deletarAluno(int id) async {
    final db = await Conection().getConection();
    await db.delete("alunos", where: "id = ?", whereArgs: [id]);
  }

  Future<List<alunos>> buscarAluno(int campo, String dado) async {
    final db = await Conection().getConection();
    List<String> lista = [
      'id like ?',
      'nome like ?',
      'matricula like ?',
      'dataNasc like ?',
    ];
    final List<Map<String, dynamic>> resultado = await db.query(
      'alunos',
      where: lista[campo],
      whereArgs: ['%$dado%'],
    );
    return List.generate(resultado.length, (index) {
      return alunos(
        id: resultado[index]['id'],
        nome: resultado[index]['nome'],
        matricula: resultado[index]['matricula'],
        datNasc: resultado[index]['dataNasc'],
      );
    });
  }
}
