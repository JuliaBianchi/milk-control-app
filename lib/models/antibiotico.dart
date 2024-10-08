class Antibiotico {
  final String? animal;
  final DateTime? data;
  final int? aplicacao;
  final int? turno;
  final String? nomeMedicacao;
  final int? diasCarencia;
  final String? observacao;

  Antibiotico(this.animal, this.data, this.aplicacao,
      this.nomeMedicacao, this.diasCarencia, this.observacao, this.turno);

  @override
  String toString() {
    return 'Antibiotico{animal: $animal, data: $data, aplicacao: $aplicacao, turno: $turno, nomeMedicacao: $nomeMedicacao, diasCarencia: $diasCarencia, observacao: $observacao}';
  }
}