import 'package:flutter/material.dart';
import 'package:sislist/models/aluno.dart';
import 'package:sislist/models/pdfFIle.dart';
import 'package:sislist/models/simpleDataBase.dart';
import 'package:sislist/pages/savePdf.dart';
import 'package:sislist/pages/selectFile.dart';

class ListaAlunos extends StatefulWidget {
  var lista;
  ListaAlunos(this.lista);
  @override
  _ListaAlunosState createState() => _ListaAlunosState(lista);
}

class _ListaAlunosState extends State<ListaAlunos> {
  final bd = SimpleDataBase.instance;
  ScrollController controller = ScrollController();
  List<Aluno> alunos;
  Map<String, dynamic> lista;
  _list() async {
    List<Aluno> alunos = await bd.getall(lista['turma']);
    setState(() {
      this.alunos = alunos;
    });
  }

  _ListaAlunosState(this.lista) {
    alunos = [];
    _list();
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

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SavePdf(lista);
        },
      ),
    );
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
