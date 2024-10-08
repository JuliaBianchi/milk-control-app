class ProducaoMensal {
  List<DateTime> periodo;
  int litrosProduzidos;
  double valorLitro;

  ProducaoMensal({
    required this.periodo,
    required this.litrosProduzidos,
    required this.valorLitro,
  });

  // Método para converter o objeto em um Map (útil para Firebase, por exemplo)
  Map<String, dynamic> toMap() {
    return {
      'periodo': periodo.map((date) => date.toIso8601String()).toList(),
      'litrosProduzidos': litrosProduzidos,
      'valorLitro': valorLitro,
    };
  }

  // Método para criar um objeto ProducaoMensal a partir de um Map
  factory ProducaoMensal.fromMap(Map<String, dynamic> map) {
    return ProducaoMensal(
      periodo: List<DateTime>.from(
        map['periodo'].map((dateString) => DateTime.parse(dateString)),
      ),
      litrosProduzidos: map['litrosProduzidos'],
      valorLitro: map['valorLitro'],
    );
  }

  @override
  String toString() {
    return 'ProducaoMensal{periodo: $periodo, litrosProduzidos: $litrosProduzidos, valorLitro: $valorLitro}';
  }
}
