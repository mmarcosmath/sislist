import 'package:flutter/material.dart';
import 'package:sislist/routes/routes.dart';
import 'package:sislist/screens/listaAlunos.dart';
import 'package:sislist/screens/paginaInicial.dart';
import 'package:sislist/screens/registrarFalta.dart';
import 'package:sislist/screens/savePdf.dart';
import 'package:sislist/screens/selectFile.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
      ),
      routes: {
        Routes.HOME: (context) => TelaInicial(),
        Routes.CARREGA_CSV: (context) => CarregaCsv(),
        Routes.LISTA_ALUNOS: (context) => ListaAlunos(),
        Routes.REG_FALTA: (context) => RegistrarFalta(),
        Routes.SAVE_PDF: (context) => SavePdf(),
      },
    );
  }
}
