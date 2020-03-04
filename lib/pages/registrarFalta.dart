import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sislist/models/simpleDataBase.dart';
import 'package:sislist/pages/listaAlunos.dart';

class RegistrarFalta extends StatefulWidget {
  @override
  _RegistrarFaltaState createState() => _RegistrarFaltaState();
}

class _RegistrarFaltaState extends State<RegistrarFalta> {
  final bd = SimpleDataBase.instance;
  List<String> turmas;
  List<DropdownMenuItem<String>> items;
  TextEditingController horarios = TextEditingController();
  TextEditingController assunto = TextEditingController();
  String _selectedTurma;
  _load() async {
    items.clear();
    turmas.clear();
    var temp = await bd.getTurma();
    setState(() {
      temp.forEach((t) {
        turmas.add(t['idturma']);
        items.add(DropdownMenuItem<String>(
          child: Text(t['idturma'],
              style: TextStyle(color: Colors.black, fontSize: 15)),
          value: t['idturma'],
        ));
        print(t);
      });
    });
    // for (var t in temp) {
    //   turmas.add(t['idturma']);
    //   print(t['idturma']);
    // }

    // for (var i = 0; i < 5; i++) {
    //   items.add(DropdownMenuItem<String>(
    //     child: Text("$i"),
    //     value: '$i',
    //   ));
    // }
    // int i = 0;
    // for (var item in turmas) {
    //   print(item);
    //   items.add(
    //     DropdownMenuItem<String>(
    //       // child: Text(item['turma']),
    //       // value: item['turma'],
    //       child: Text('$i'),
    //       value: '$i',
    //     ),
    //   );
    //   i++;
  }

  _RegistrarFaltaState() {
    turmas = [];
    items = [];
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registrar Presença'),
        // actions: <Widget>[
        //   RaisedButton(onPressed: () {
        //     _load();
        //   })
        // ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.0,
                      ),
                    ),
                    child: DropdownButton<String>(
                      items: this.items,
                      value: _selectedTurma,
                      hint: Text('Selecione a Turma'),
                      iconSize: 30,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedTurma = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  controller: horarios,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Horarios',
                    labelText: 'Horarios',
                  ),
                  maxLines: 1,
                ),
              ),
              TextFormField(
                enabled: true,
                keyboardType: TextInputType.text,
                controller: assunto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Assunto',
                  labelText: 'Assunto',
                ),
                maxLines: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      child: Text("Voltar"),
                    ),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ListaAlunos(_selectedTurma);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Proximo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
