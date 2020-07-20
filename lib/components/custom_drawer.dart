import 'package:flutter/material.dart';
import 'package:sislist/pages/registrarFalta.dart';
import 'package:sislist/pages/selectFile.dart';

import 'custom_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
