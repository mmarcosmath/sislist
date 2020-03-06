import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sislist/models/aluno.dart';
import 'package:sislist/models/simpleDataBase.dart';

class CarregaCsv extends StatefulWidget {
  @override
  _CarregaCsvState createState() => new _CarregaCsvState();
}

class _CarregaCsvState extends State<CarregaCsv> {
  String _path = '';
  String _extension;
  List<List<dynamic>> fields;
  TextEditingController _controller = new TextEditingController();
  final bd = SimpleDataBase.instance;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  Future<void> _openFileExplorer() async {
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

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: const Text('Selecionar arquivo'),
      ),
      body: new Center(
          child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: () async {
                await _openFileExplorer();
                // Navigator.pop(context);
              },
              child: new Text("Abrir"),
            ),
            Text(_path),
          ],
        ),
      )),
    );
  }
}

String _path = '';
String _extension;
List<List<dynamic>> fields;

final bd = SimpleDataBase.instance;

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
