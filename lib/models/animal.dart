

class Animal {
  final String? nome;
  final String? identificacao;
  final String? raca;
  final String? faixaEtaria;
  final String? categoria;
  final String? genero;

  Animal(
    this.nome,
    this.identificacao,
    this.raca,
    this.faixaEtaria,
    this.categoria,
    this.genero,
  );

  @override
  String toString() {
    return 'Animal{nome: $nome, identificacao: $identificacao, raca: $raca, faixaEtaria: $faixaEtaria, categoria: $categoria, genero: $genero}';
  }
}
