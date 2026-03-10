import 'package:flutter/material.dart';
import 'player_screen.dart'; // Importa o player que criamos acima

class CanalAberto {
  final String nome;
  final String url;
  final String logo;

  CanalAberto({required this.nome, required this.url, required this.logo});
}

class CanaisScreen extends StatelessWidget {
  CanaisScreen({super.key});

  final List<CanalAberto> canais = [
    CanalAberto(nome: "Band SP", url: "https://embedtvonline.com/bandsp/", logo: "https://vipapp.site/images/bandsp.png"),
    CanalAberto(nome: "Globo MG", url: "https://embedtvonline.com/globomg/", logo: "https://vipapp.site/images/globo.webp"),
    CanalAberto(nome: "Globo RJ", url: "https://embedtvonline.com/globorj/", logo: "https://vipapp.site/images/globo.webp"),
    CanalAberto(nome: "Globo RS", url: "https://embedtvonline.com/globors/", logo: "https://vipapp.site/images/globo.webp"),
    CanalAberto(nome: "Globo SP", url: "https://embedtvonline.com/globosp/", logo: "https://vipapp.site/images/globo.webp"),
    CanalAberto(nome: "Record MG", url: "https://embedtvonline.com/recordmg/", logo: "https://vipapp.site/images/record.png"),
    CanalAberto(nome: "Record RJ", url: "https://embedtvonline.com/recordrj/", logo: "https://vipapp.site/images/record.png"),
    CanalAberto(nome: "Record SP", url: "https://embedtvonline.com/recordsp/", logo: "https://vipapp.site/images/record.png"),
    CanalAberto(nome: "RedeTV!", url: "https://embedtvonline.com/redetv/", logo: "https://vipapp.site/images/redetv.png"),
    CanalAberto(nome: "SBT SP", url: "https://embedtvonline.com/sbtsp/", logo: "https://vipapp.site/images/sbtsp.png"),
    CanalAberto(nome: "TV Cultura", url: "https://embedtvonline.com/tvcultura/", logo: "https://vipapp.site/images/tvcultura.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canais Abertos"),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: canais.length,
        itemBuilder: (context, index) {
          final canal = canais[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PlayerScreen(url: canal.url, titulo: canal.nome))
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    canal.logo,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.tv, size: 50, color: Colors.white24),
                  ),
                  const SizedBox(height: 10),
                  Text(canal.nome, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}