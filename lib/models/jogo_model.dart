class Jogo {
  final String titulo;
  final String url;
  final String imagem;
  Jogo({required this.titulo, required this.url, required this.imagem});
}

class DetalhesJogo {
  final String titulo;
  final String horario;
  final String descricao;
  final String imagemPlayer;
  final List<OpcaoPlayer> opcoes;

  DetalhesJogo({
    required this.titulo,
    required this.horario,
    required this.descricao,
    required this.imagemPlayer,
    required this.opcoes,
  });
}

class OpcaoPlayer {
  final String nome;
  final String url;
  OpcaoPlayer({required this.nome, required this.url});
}