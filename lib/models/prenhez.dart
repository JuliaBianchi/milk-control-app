class Prenhez {
  final String? animal;
  final DateTime? data;
  final String? observacao;

  Prenhez({this.animal, this.data, this.observacao});

  @override
  String toString() {
    return 'Prenhez{animal: $animal, data: $data, observacao: $observacao}';
  }
}