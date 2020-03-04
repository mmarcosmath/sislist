import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sislist/models/aluno.dart';
import 'package:sqflite/sqflite.dart';

class SimpleDataBase {
  static final _databaseName = "SimpleDataBase.db";
  static final _databaseVersion = 1;

  SimpleDataBase._privateConstructor();
  static final SimpleDataBase instance = SimpleDataBase._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE aluno(
      matricula TEXT,
      nome TEXT,
      turma TEXT,
      presente TEXT)
      ''');
    await db.execute('''
      CREATE TABLE turma(
      idturma TEXT PRIMARY KEY
      )
      ''');
    // Map<String, dynamic> row = {
    //   'classificacao': '004',
    //   'nome': 'Ciência da Computação',
    // };
    // await db.insert('classificacao', row);
  }

  Future insert(Aluno aluno) async {
    Database db = await instance.database;
    await db.insert('aluno', aluno.toJson());
  }

  Future insertTurma(String turma) async {
    Database db = await instance.database;
    try{
    await db.insert('turma', {'idturma': '$turma'});
    }catch (SqfliteDatabaseException ) {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> getTurma() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM turma');
    if (res == null) return [];
    return res;
  }

  Future<List<Aluno>> list() async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM aluno');
    List<Aluno> alunos = [];
    if (res != null) {
      for (var a in res) {
        alunos.add(
          Aluno(
              matricula: a.values.elementAt(0),
              nome: a.values.elementAt(1),
              turma: a.values.elementAt(2),
              presente: ('${a.values.elementAt(3)}' == '0') ? true : false),
        );
      }
    }
    return res != null ? alunos : [];
  }

  Future<List> getall(String turma) async {
    Database db = await instance.database;
    // var res = await db.rawQuery('SELECT * FROM aluno WHERE turma == \'$turma\'');
    var res = await db.query('aluno', where: 'turma = ?', whereArgs: [turma]);
    // var res = await db.query('aluno');

    List<Aluno> list =
        res.isNotEmpty ? res.map((c) => Aluno.fromJson(c)).toList() : [];
    return list;
  }

  Future<void> deleteTable() async {
    Database db = await instance.database;
    return await db.execute('''DELETE FROM aluno''');
  }

  Future<List<Map<String, dynamic>>> teste() async {
    Database db = await instance.database;
    return await db.query('aluno');
    // List<Aluno> alunos = [];
    // if (res != null) {
    //   for (var a in res) {
    //     alunos.add(
    //       Aluno(
    //           matricula: a.values.elementAt(0),
    //           nome: a.values.elementAt(1),
    //           turma: a.values.elementAt(2),
    //           presente: (int.parse('${a.values.elementAt(3)}') == 0) ? true : false),
    //     );
    //   }
    // }
    // return res!=null?alunos:[];
  }
}
