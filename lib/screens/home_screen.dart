import 'package:flutter/material.dart';
import 'lista_jogos_screen.dart';
import 'canais_screen.dart';
import 'canais_estaticos_screen.dart'; // Nova tela

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FUTEBOL PLAY', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: ListView( // Alterado para ListView para permitir rolagem
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryCard(
            context,
            'Canais Abertos',
            'assets/images/canaisabertos.webp',
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CanaisScreen())),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            context,
            'Futebol Ao Vivo',
            'assets/images/futebol.jpg', // Corrigido para .jpg
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ListaJogosScreen())),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            context,
            'Filmes e Séries',
            'assets/images/filmes_series.jpg', // Novo .jpg
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CanaisEstaticosScreen(categoria: "Filmes"))),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            context,
            'Infantil',
            'assets/images/infantil.jpg', // Novo .jpg
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CanaisEstaticosScreen(categoria: "Infantil"))),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            context,
            'Reality Show (BBB)',
            'assets/images/bbb.webp', // Novo .webp
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => CanaisEstaticosScreen(categoria: "BBB"))),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 150, // Diminuído um pouco para caber mais na tela
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))
          ],
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              shadows: [Shadow(color: Colors.black, blurRadius: 10, offset: Offset(2, 2))],
            ),
          ),
        ),
      ),
    );
  }
}