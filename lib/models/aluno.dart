class Aluno {
  String matricula;
  String nome;
  String turma;
  bool presente;

  Aluno({this.matricula, this.nome, this.turma, this.presente});

  Aluno.fromJson(Map<String, dynamic> json) {
    matricula = json['matricula'];
    nome = json['nome'];
    turma = json['turma'];
    presente = (json['presente'] =='0')?true:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matricula'] = this.matricula;
    data['nome'] = this.nome;
    data['turma'] = this.turma;
    data['presente'] = this.presente ? 0 : 1;
    return data;
  }
}
