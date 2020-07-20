import 'package:flutter/material.dart';
import 'package:sislist/components/custom_drawer.dart';
import 'package:sislist/components/custom_list_tile.dart';
import 'package:sislist/pages/registrarFalta.dart';
import 'package:sislist/pages/selectFile.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Diario de Classe"),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              'imagens/logo.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
