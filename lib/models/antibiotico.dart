class Antibiotico {
  final String? animal;
  final String? data;
  final String? horario;
  final int? aplicacao;
  final String? nomeMedicacao;
  final int? diasCarencia;
  final String? observacao;

  Antibiotico(this.animal, this.data, this.horario, this.aplicacao,
      this.nomeMedicacao, this.diasCarencia, this.observacao);

  @override
  String toString() {
    return 'Antibiotico{animal: $animal, data: $data, horario: $horario, aplicacao: $aplicacao, nomeMedicacao: $nomeMedicacao, diasCarencia: $diasCarencia, observacao: $observacao}';
  }
}