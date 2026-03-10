import 'package:flutter/material.dart';
import 'player_screen.dart';

class CanalItem {
  final String nome;
  final String url;
  final String logo;
  CanalItem({required this.nome, required this.url, required this.logo});
}

class CanaisEstaticosScreen extends StatelessWidget {
  final String categoria;
  CanaisEstaticosScreen({super.key, required this.categoria});

  // Banco de dados COMPLETO extraído do seu HTML
  final Map<String, List<CanalItem>> data = {
    "BBB": [
      CanalItem(nome: "BBB 01", url: "https://embedtvonline.com/bbb01/", logo: "https://vipapp.site/images/bbb.png"),
      CanalItem(nome: "BBB 02", url: "https://embedtvonline.com/bbb02/", logo: "https://vipapp.site/images/bbb.png"),
      CanalItem(nome: "BBB 03", url: "https://embedtvonline.com/bbb03/", logo: "https://vipapp.site/images/bbb.png"),
      CanalItem(nome: "BBB 04", url: "https://embedtvonline.com/bbb04/", logo: "https://vipapp.site/images/bbb.png"),
      CanalItem(nome: "BBB 05", url: "https://embedtvonline.com/bbb05/", logo: "https://vipapp.site/images/bbb.png"),
      CanalItem(nome: "BBB 06", url: "https://embedtvonline.com/bbb06/", logo: "https://vipapp.site/images/bbb.png"),
    ],
    "Infantil": [
      CanalItem(nome: "Cartoonito", url: "https://embedtvonline.com/cartoonito/", logo: "https://vipapp.site/images/cartoonito.png"),
      CanalItem(nome: "Cartoon Network", url: "https://embedtvonline.com/cartoonnetwork/", logo: "https://vipapp.site/images/cartoonnetwork.png"),
      CanalItem(nome: "Discovery Kids", url: "https://embedtvonline.com/discoverykids/", logo: "https://vipapp.site/images/discoverykids.png"),
      CanalItem(nome: "DreamWorks", url: "https://embedtvonline.com/dreamworks/", logo: "https://vipapp.site/images/dreamworks.png"),
      CanalItem(nome: "Gloob", url: "https://embedtvonline.com/gloob/", logo: "https://vipapp.site/images/gloob.png"),
      CanalItem(nome: "Gloobinho", url: "https://embedtvonline.com/gloobinho/", logo: "https://vipapp.site/images/gloobinho.png"),
      CanalItem(nome: "Nickelodeon", url: "https://embedtvonline.com/nickelodeon/", logo: "https://vipapp.site/images/nickelodeon.png"),
      CanalItem(nome: "Nick Jr.", url: "https://embedtvonline.com/nickjr/", logo: "https://vipapp.site/images/nickjr.png"),
      CanalItem(nome: "Tooncast", url: "https://embedtvonline.com/tooncast/", logo: "https://vipapp.site/images/tooncast.png"),
    ],
    "Filmes": [
      // --- Filmes e Séries ---
      CanalItem(nome: "A&E", url: "https://embedtvonline.com/aee/", logo: "https://vipapp.site/images/aee.png"),
      CanalItem(nome: "AMC", url: "https://embedtvonline.com/amc/", logo: "https://vipapp.site/images/amc.png"),
      CanalItem(nome: "AXN", url: "https://embedtvonline.com/axn/", logo: "https://vipapp.site/images/axn.png"),
      CanalItem(nome: "Cinemax", url: "https://embedtvonline.com/cinemax/", logo: "https://vipapp.site/images/cinemax.png"),
      CanalItem(nome: "Globoplay Novelas", url: "https://embedtvonline.com/globoplaynovelas/", logo: "https://vipapp.site/images/globoplaynovelas.png"),
      CanalItem(nome: "HBO", url: "https://embedtvonline.com/hbo/", logo: "https://vipapp.site/images/hbo.png"),
      CanalItem(nome: "HBO 2", url: "https://embedtvonline.com/hbo2/", logo: "https://vipapp.site/images/hbo2.png"),
      CanalItem(nome: "HBO Family", url: "https://embedtvonline.com/hbofamily/", logo: "https://vipapp.site/images/hbofamily.png"),
      CanalItem(nome: "HBO Mundi", url: "https://embedtvonline.com/hbomundi/", logo: "https://vipapp.site/images/hbomundi.png"),
      CanalItem(nome: "HBO Plus", url: "https://embedtvonline.com/hboplus/", logo: "https://vipapp.site/images/hboplus.png"),
      CanalItem(nome: "HBO Pop", url: "https://embedtvonline.com/hbopop/", logo: "https://vipapp.site/images/hbopop.png"),
      CanalItem(nome: "HBO Signature", url: "https://embedtvonline.com/hbosignature/", logo: "https://vipapp.site/images/hbosignature.png"),
      CanalItem(nome: "HBO Xtreme", url: "https://embedtvonline.com/hboxtreme/", logo: "https://vipapp.site/images/hboxtreme.png"),
      CanalItem(nome: "Megapix", url: "https://embedtvonline.com/megapix/", logo: "https://vipapp.site/images/megapix.png"),
      CanalItem(nome: "Paramount Network", url: "https://embedtvonline.com/paramountnetwork/", logo: "https://vipapp.site/images/paramountnetwork.png"),
      CanalItem(nome: "Sony Channel", url: "https://embedtvonline.com/sonychannel/", logo: "https://vipapp.site/images/sonychannel.png"),
      CanalItem(nome: "Space", url: "https://embedtvonline.com/space/", logo: "https://vipapp.site/images/space.png"),
      CanalItem(nome: "Studio Universal", url: "https://embedtvonline.com/studiouniversal/", logo: "https://vipapp.site/images/studiouniversal.png"),
      CanalItem(nome: "Telecine Action", url: "https://embedtvonline.com/tcaction/", logo: "https://vipapp.site/images/tcaction.png"),
      CanalItem(nome: "Telecine Cult", url: "https://embedtvonline.com/tccult/", logo: "https://vipapp.site/images/tccult.png"),
      CanalItem(nome: "Telecine Fun", url: "https://embedtvonline.com/tcfun/", logo: "https://vipapp.site/images/tcfun.png"),
      CanalItem(nome: "Telecine Pipoca", url: "https://embedtvonline.com/tcpipoca/", logo: "https://vipapp.site/images/tcpipoca.png"),
      CanalItem(nome: "Telecine Premium", url: "https://embedtvonline.com/tcpremium/", logo: "https://vipapp.site/images/tcpremium.png"),
      CanalItem(nome: "Telecine Touch", url: "https://embedtvonline.com/tctouch/", logo: "https://vipapp.site/images/tctouch.png"),
      CanalItem(nome: "TNT", url: "https://embedtvonline.com/tnt/", logo: "https://vipapp.site/images/tnt.png"),
      CanalItem(nome: "TNT Novelas", url: "https://embedtvonline.com/tntnovelas/", logo: "https://vipapp.site/images/tntnovelas.png"),
      CanalItem(nome: "TNT Series", url: "https://embedtvonline.com/tntseries/", logo: "https://vipapp.site/images/tntseries.png"),
      CanalItem(nome: "Universal TV", url: "https://embedtvonline.com/universaltv/", logo: "https://vipapp.site/images/universaltv.png"),
      CanalItem(nome: "Warner Channel", url: "https://embedtvonline.com/warner/", logo: "https://vipapp.site/images/warner.png"),

    ],
  };

  @override
  Widget build(BuildContext context) {
    final lista = data[categoria] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoria == "BBB" ? "Reality Show" : categoria),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: lista.length,
        itemBuilder: (context, index) {
          final item = lista[index];
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerScreen(url: item.url, titulo: item.nome),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.network(
                        item.logo,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(Icons.tv, size: 40, color: Colors.white24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                    child: Text(
                      item.nome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}