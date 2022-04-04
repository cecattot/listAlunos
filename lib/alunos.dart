class alunos {
  int id;
  String nome;
  String matricula;
  String datNasc;

  alunos(
      {required this.id,
        required this.nome,
        required this.matricula,
        required this.datNasc});

  Map<String, dynamic> criarMap() {
    return {
      'id': id,
      'nome': nome,
      'matricula': matricula,
      'dataNasc': datNasc.toString()
    };
  }

  @override
  String toString() {
    //TODO: implement toSting
    return "aluno {id: $id, nome: $nome, matricula: $matricula, data de nascimento: $datNasc}";
  }
}