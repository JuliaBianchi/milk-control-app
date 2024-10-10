class Animal {
  final String? uuid;
  final int? identificacao;
  final String? nome;
  final String? raca;
  final String? faixaEtaria;
  final String? categoria;
  final String? genero;
  final bool ativado;

  Animal({
    this.uuid,
    this.identificacao,
    this.nome,
    this.raca,
    this.faixaEtaria,
    this.categoria,
    this.genero,
    required this.ativado
  });

  // Método toMap: Converte o objeto Animal em um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'identificacao': identificacao,
      'nome': nome,
      'raca': raca,
      'faixaEtaria': faixaEtaria,
      'categoria': categoria,
      'genero': genero,
      'ativado': ativado,
    };
  }

  // Método fromMap: Converte um Map<String, dynamic> em um objeto Animal
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      nome: map['nome'] as String?,
      uuid: map['uuid'] as String?,
      identificacao: map['identificacao'] as int?,
      raca: map['raca'] as String?,
      faixaEtaria: map['faixaEtaria'] as String?,
      categoria: map['categoria'] as String?,
      genero: map['genero'] as String?,
      ativado: map['ativado'] as bool,
    );
  }

  @override
  String toString() {
    return 'Animal{nome: $nome, uuid: $uuid,identificacao: $identificacao, raca: $raca, faixaEtaria: $faixaEtaria, categoria: $categoria, genero: $genero}';
  }
}
