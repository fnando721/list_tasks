class Task{
  String nome;
  String? categoria;
  String descricao;
  DateTime dtConclusao;
  bool estaFeito;

  Task( this.nome,this.categoria ,this.descricao, this.dtConclusao, this.estaFeito );

  factory Task.fromJson(Map<String,dynamic> map ) {
    return Task(
     map['nome'],
     map['categoria'],
     map['descricao'],
     map['drConclusao'],
     map['estaFeito']
    );
  }
  }