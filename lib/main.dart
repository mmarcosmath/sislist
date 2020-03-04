import 'package:flutter/material.dart';
import 'package:sislist/pages/listaAlunos.dart';
import 'package:sislist/pages/registrarFalta.dart';
import 'package:sislist/pages/savePdf.dart';
import 'package:sislist/pages/selectFile.dart';

void main() => runApp(PaginaInicial());

class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RegistrarFalta(),
    );
  }
}
