import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sislist/models/data.dart';

void pdfFile(String dir, Map<String, dynamic> lista) {
  final Document pdf = Document();
  Data data = Data();

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('Relatorio',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
        );
      },
      build: (Context context) => <Widget>[
        Header(
          level: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Relatorio', textScaleFactor: 2),
              Text('${lista['turma']}', textScaleFactor: 2),
              Text('$data', textScaleFactor: 2),
            ],
          ),
        ),
        Paragraph(text: 'Assunto: ${lista['assunto']}'),
        Paragraph(text: 'Alunos que faltaram:'),
        Table.fromTextArray(context: context, data: lista['listaPdf']),
      ],
    ),
  );
  var directory = '$dir/${lista['turma']} - ${data.toString()}.pdf';
  final File file = File(directory);
  file.writeAsBytesSync(pdf.save());
  ShareExtend.share(directory, 'file');
}
