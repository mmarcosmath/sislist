import 'dart:io';

import 'package:flutter/material.dart';
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
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100)),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
      drawer: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Material(
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
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.green,
                    offset: new Offset(0, 5.0),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        CustomListTile(
                          "Registrar Presença",
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrarFalta()));
                          },
                          Icons.playlist_add_check,
                        ),
                        CustomListTile(
                          "Importar Dados",
                          () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarregaCsv()));
                          },
                          Icons.archive,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

class CustomListTile extends StatelessWidget {
  String texto;
  Function tela;
  IconData icon;
  CustomListTile(this.texto, this.tela, this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          //splashColor: Colors.blueAccent,
          onTap: tela,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        texto,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
