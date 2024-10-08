class Dieta {
  List<DateTime> periodo;
  String qtdAnimaisLactacao;
  String obs;

  Dieta({
    required this.periodo,
    required this.qtdAnimaisLactacao,
    required this.obs,
  });

  Map<String, dynamic> toMap() {
    return {
      'periodo': periodo.map((date) => date.toIso8601String()).toList(),
      'qtdAnimaisLactacao': qtdAnimaisLactacao,
      'obs': obs,
    };
  }

  factory Dieta.fromMap(Map<String, dynamic> map) {
    return Dieta(
      periodo: List<DateTime>.from(
        map['periodo'].map((dateString) => DateTime.parse(dateString)),
      ),
      qtdAnimaisLactacao: map['qtdAnimaisLactacao'],
      obs: map['obs'],
    );
  }

  @override
  String toString() {
    return 'Dieta{periodo: $periodo, qtdAnimaisLactacao: $qtdAnimaisLactacao, obs: $obs}';
  }
}
