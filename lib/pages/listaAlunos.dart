import 'package:flutter/material.dart';
import 'package:sislist/models/aluno.dart';
import 'package:sislist/models/simpleDataBase.dart';
import 'package:sislist/pages/selectFile.dart';

class ListaAlunos extends StatefulWidget {
  String turma;
  ListaAlunos(this.turma);
  @override
  _ListaAlunosState createState() => _ListaAlunosState(turma);
}

class _ListaAlunosState extends State<ListaAlunos> {
  String turma;
  final bd = SimpleDataBase.instance;
  ScrollController controller = ScrollController();
  List<Aluno> alunos;

  _list() async {
    List<Aluno> alunos = await bd.getall(turma);
    setState(() {
      this.alunos = alunos;
    });
  }

  _ListaAlunosState(this.turma) {
    alunos = [];
    _list();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(turma)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () async {
              await bd.deleteTable();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarregaCsv(),
                ),
              );
              print("iu");
              _list();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _list();
        },
        child: ListView.builder(
            controller: controller,
            itemCount: alunos.length,
            itemBuilder: (BuildContext context, int index) {
              var aluno = alunos[index];
              return Card(
                child: CheckboxListTile(
                  title: Text(aluno.nome),
                  subtitle: Text('Matricula: '+aluno.matricula),
                  value: aluno.presente,
                  onChanged: (value) {
                    setState(() {
                      aluno.presente = value;
                    });
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // for (var i = 0; i < 10; i++) {
          //   setState(() {
          //      alunos.add(Aluno(
          //         nome: 'Marcos Matheus Nascimento Silva',
          //         matricula: '20181BCC.CAX0019',
          //         presente: false,
          //         turma: 'CC5'));
          //   });
          // }
        },
      ),
    );
  }
}
