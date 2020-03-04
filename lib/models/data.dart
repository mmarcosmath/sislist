class Data {
  DateTime data = DateTime.now();
  Data();

  @override
  String toString() {
    var dia = '';
    var mes = '';
    var ano = '${data.year}';

    if (data.day < 10) {
      dia = '0' + '${data.day}';
    }
    if (data.month < 10) {
      mes = '0' + '${data.month}';
    }

    return dia + '-' + mes + '-' + ano;
  }
}