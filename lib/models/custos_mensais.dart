class CustosMensais {
  List<DateTime>? periodo;
  String? descricao;
  double? valor;


  CustosMensais({
    this.periodo,
    this.descricao,
    this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'periodo' : periodo,
      'descricao': descricao,
      'valor': valor,
    };
  }

  factory CustosMensais.fromMap(Map<String, dynamic> map) {
    return CustosMensais(
      periodo: map['periodo'],
      descricao: map['descricao'],
      valor: map['valor'],
    );
  }

  @override
  String toString() {
    return 'Gastos(periodo: $periodo, descricao: $descricao, valor: $valor)';
  }
}
