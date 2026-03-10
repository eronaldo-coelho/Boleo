import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:flutter/foundation.dart';
import '../models/jogo_model.dart';

class ScraperService {
  static const String baseUrl = 'https://multicanaishd.autos/futebol/';
  static const String meuProxy = 'https://linguai.com.br/proxy.php';

  static String _prepararUrl(String url) => kIsWeb ? '$meuProxy?url=${Uri.encodeComponent(url)}' : url;

  static String _limparTexto(String texto) {
    return texto
        .replaceAll(RegExp(r'Multicanais', caseSensitive: false), 'nosso app')
        .replaceAll(RegExp(r'multicanaishd\.autos', caseSensitive: false), 'Futebol Play Ao Vivo');
  }

  static Future<List<Jogo>> getJogos() async {
    try {
      final url = _prepararUrl(baseUrl);
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64 AppleWebKit/537.36)',
      });
      if (response.statusCode != 200) throw Exception('Erro');

      var document = parser.parse(response.body);
      var elementos = document.querySelectorAll('ul.match li');
      List<Jogo> lista = [];

      for (var elemento in elementos) {
        var linkNode = elemento.querySelector('h2 a');
        var imgNode = elemento.querySelector('a img');
        if (linkNode != null && imgNode != null) {
          lista.add(Jogo(
            titulo: _limparTexto(linkNode.text.trim()),
            url: linkNode.attributes['href'] ?? '',
            imagem: imgNode.attributes['data-src'] ?? imgNode.attributes['src'] ?? '',
          ));
        }
      }
      return lista;
    } catch (e) { return []; }
  }

  static Future<DetalhesJogo?> getDetalhes(String urlJogo) async {
    try {
      final url = _prepararUrl(urlJogo);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return null;

      var doc = parser.parse(response.body);
      List<OpcaoPlayer> opcoes = [];
      doc.querySelectorAll('#players a').forEach((link) {
        opcoes.add(OpcaoPlayer(nome: link.text.trim(), url: link.attributes['data-url'] ?? ''));
      });

      return DetalhesJogo(
        titulo: _limparTexto(doc.querySelector('#single .content h1')?.text.trim() ?? ''),
        horario: doc.querySelector('#single .content h4')?.text.trim() ?? '',
        descricao: _limparTexto(doc.querySelector('.desc')?.text.trim() ?? ''),
        imagemPlayer: doc.querySelector('#player img')?.attributes['src'] ?? '',
        opcoes: opcoes,
      );
    } catch (e) { return null; }
  }
}