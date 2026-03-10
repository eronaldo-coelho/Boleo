import 'package:flutter/material.dart';
import '../models/jogo_model.dart';
import '../services/scraper_service.dart';
import 'player_screen.dart'; // Importando o novo player compartilhado

class ListaJogosScreen extends StatefulWidget {
  const ListaJogosScreen({super.key});

  @override
  State<ListaJogosScreen> createState() => _ListaJogosScreenState();
}

class _ListaJogosScreenState extends State<ListaJogosScreen> {
  List<Jogo> _todosJogos = [];
  List<Jogo> _jogosFiltrados = [];
  bool _carregando = true;
  String _erro = '';

  final TextEditingController _pesquisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarJogos();
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  Future<void> _carregarJogos() async {
    setState(() {
      _carregando = true;
      _erro = '';
    });

    try {
      final jogos = await ScraperService.getJogos();
      setState(() {
        _todosJogos = jogos;
        _jogosFiltrados = jogos;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = 'Erro ao carregar os jogos. Verifique sua conexão.';
        _carregando = false;
      });
    }
  }

  void _filtrarJogos(String texto) {
    setState(() {
      if (texto.isEmpty) {
        _jogosFiltrados = _todosJogos;
      } else {
        _jogosFiltrados = _todosJogos.where((jogo) {
          return jogo.titulo.toLowerCase().contains(texto.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            title: const Text('Jogos de Hoje'),
            actions: [
              IconButton(icon: const Icon(Icons.refresh), onPressed: _carregarJogos)
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _pesquisaController,
                  onChanged: _filtrarJogos,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar time ou campeonato...',
                    prefixIcon: const Icon(Icons.search, color: Colors.greenAccent),
                    filled: true,
                    fillColor: const Color(0xFF1E293B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), 
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_carregando)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: Colors.greenAccent))
            )
          else if (_erro.isNotEmpty)
            SliverFillRemaining(child: Center(child: Text(_erro)))
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildCardJogo(_jogosFiltrados[index], context),
                  childCount: _jogosFiltrados.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCardJogo(Jogo jogo, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => DetalhesJogoScreen(jogo: jogo))
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // CORRIGIDO
              blurRadius: 5, 
              offset: const Offset(0, 3)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                jogo.imagem, 
                fit: BoxFit.cover, 
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF1E293B), 
                  child: const Icon(Icons.sports_soccer, color: Colors.white24)
                )
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9), // CORRIGIDO
                      Colors.transparent
                    ], 
                    begin: Alignment.bottomCenter, 
                    end: Alignment.topCenter
                  )
                )
              ),
              Positioned(
                bottom: 12, left: 12, right: 12,
                child: Text(
                  jogo.titulo, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), 
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetalhesJogoScreen extends StatelessWidget {
  final Jogo jogo;
  const DetalhesJogoScreen({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DetalhesJogo?>(
        future: ScraperService.getDetalhes(jogo.url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.greenAccent));
          }
          if (!snapshot.hasData) return const Center(child: Text('Erro ao carregar detalhes.'));
          
          final detalhes = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200, 
                pinned: true, 
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(jogo.imagem, fit: BoxFit.cover)
                )
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detalhes.titulo, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.greenAccent, size: 18),
                          const SizedBox(width: 5),
                          Text(detalhes.horario, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text('CANAIS DISPONÍVEIS:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10, 
                        runSpacing: 10,
                        children: detalhes.opcoes.map((opt) => ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E293B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          onPressed: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => PlayerScreen(url: opt.url, titulo: opt.nome))
                          ),
                          icon: const Icon(Icons.play_circle_fill, color: Colors.greenAccent),
                          label: Text(opt.nome),
                        )).toList(),
                      ),
                      const SizedBox(height: 30),
                      Text(detalhes.descricao, style: const TextStyle(color: Colors.white60, fontSize: 14)),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}