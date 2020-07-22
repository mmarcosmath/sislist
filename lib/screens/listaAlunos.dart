import 'package:flutter/material.dart';
import 'package:sislist/models/aluno.dart';
import 'package:sislist/models/simpleDataBase.dart';
import 'package:sislist/routes/routes.dart';

class ListaAlunos extends StatefulWidget {
  @override
  _ListaAlunosState createState() => _ListaAlunosState();
}

class _ListaAlunosState extends State<ListaAlunos> {
  final bd = SimpleDataBase.instance;
  ScrollController controller = ScrollController();
  List<Aluno> alunos = [];
  Map<String, dynamic> lista;
  bool getList = true;

  _list() async {
    if (getList) {
      List<Aluno> alunos = [];
      alunos = await bd.getall(lista['turma']);
      setState(() {
        this.alunos = alunos;
      });
      getList = false;
    }
  }

  Future<void> convertListString() async {
    List<List<String>> listaPdf = [];
    // List<String> aux = ['Date', 'PDF Version', 'Acrobat Version'];
    listaPdf.add(<String>['Matricula', 'Nome', 'Horarios']);
    for (var a in alunos) {
      if (a.presente) {
        continue;
      }
      listaPdf.add(<String>[a.matricula, a.nome, '${lista['horarios']}']);
    }
    lista.addAll({'listaPdf': listaPdf});

    await Navigator.of(context).pushNamed(Routes.SAVE_PDF, arguments: lista);
  }

  @override
  Widget build(BuildContext context) {
    lista = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _list();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(lista['turma'])),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.camera_alt),
          //   onPressed: () async {
          //     await bd.deleteTable();
          //     await Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CarregaCsv(),
          //       ),
          //     );
          //     print("iu");
          //     _list();
          //   },
          // ),
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
                  subtitle: Text('Matricula: ' + aluno.matricula),
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
          convertListString();
        },
      ),
    );
  }
}
