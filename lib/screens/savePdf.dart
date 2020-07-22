import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:directory_picker/directory_picker.dart';
import 'package:sislist/models/pdfFIle.dart';

class SavePdf extends StatefulWidget {
  @override
  _SavePdfState createState() => _SavePdfState();
}

class _SavePdfState extends State<SavePdf> {
  Directory selectedDirectory;
  Map<String, dynamic> lista;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickDirectory(BuildContext context) async {
    Directory directory = selectedDirectory;
    if (directory == null) {
      directory = await getExternalStorageDirectory();
    }

    Directory newDirectory = await DirectoryPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: directory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));

    setState(() {
      selectedDirectory = newDirectory;
    });

    pdfFile(selectedDirectory.path, lista);
  }

  @override
  Widget build(BuildContext context) {
    lista = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Salvar PDF'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Diretorio selecionado:',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text((selectedDirectory != null) ? selectedDirectory.path : '',
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickDirectory(context),
        tooltip: 'Pick Directory',
        child: Icon(Icons.create_new_folder),
      ),
    );
  }
}
