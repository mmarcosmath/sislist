import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'aluno.dart';
import 'simpleDataBase.dart';

class ReadCsv {
  String _extension;
  List<List<dynamic>> fields;
  var bd = SimpleDataBase.instance;
  String _path = '';

  String get path => _path;

  Future<void> openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath(
          type: FileType.ANY, fileExtension: _extension);
    } on PlatformException catch (e) {
      print("Abrir" + e.toString());
    }
    if (_path == null) return;

    final input = File(_path).openRead();
    var fields = await input
        .transform(Latin1Decoder())
        .transform(CsvToListConverter())
        .toList();

    List<Aluno> list = [];
    for (var i in fields) {
      var p = [];
      var a = '$i';
      a = a.substring(1, a.indexOf(']'));
      for (var i = 0; i < a.length; i++) {
        if ((a[i] == ';') || (a[i] == ',')) {
          p.add(i);
        }
      }

      list.add(
        Aluno(
            matricula: '${a.substring(0, p[0])}',
            nome: '${a.substring(p[0] + 1, p[1])}',
            turma: '${a.substring(p[1] + 1, a.length)}',
            presente: false),
      );
    }

    for (var aluno in list) {
      await bd.insert(aluno);
      await bd.insertTurma(aluno.turma);
    }
  }
}
