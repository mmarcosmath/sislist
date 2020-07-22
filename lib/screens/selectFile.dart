import 'package:flutter/material.dart';
import 'package:sislist/models/read_csv.dart';

class CarregaCsv extends StatelessWidget {
  final readCsv = ReadCsv();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: const Text('Selecionar arquivo'),
      ),
      body: Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () async {
                  readCsv.openFileExplorer();
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Arquivo carregado'),
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: new Text("Abrir"),
              ),
              Text(readCsv.path),
            ],
          ),
        ),
      ),
    );
  }
}
