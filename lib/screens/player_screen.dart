import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';

class PlayerScreen extends StatefulWidget {
  final String url;
  final String titulo;

  const PlayerScreen({super.key, required this.url, required this.titulo});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (req) {
          // Bloqueia tentativas de abrir sites externos (popups de anúncios)
          final host = Uri.parse(widget.url).host;
          if (req.url.contains(host) || req.url.contains("embedtvonline.com") || req.url.contains("about:blank")) {
            return NavigationDecision.navigate;
          }
          debugPrint("Bloqueado popup: ${req.url}");
          return NavigationDecision.prevent;
        },
        onPageFinished: (_) {
          if (mounted) setState(() => _isLoading = false);
        },
      ))
      ..loadHtmlString(_buildHtml(), baseUrl: widget.url);
  }

  String _buildHtml() {
    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
          <style>
            body { margin: 0; background: #000; overflow: hidden; display: flex; justify-content: center; align-items: center; height: 100vh; }
            iframe { width: 100%; height: 100%; border: none; }
            /* Bloqueio de elementos de propaganda via CSS */
            [class*="ad"], [id*="ad"], .adsbygoogle, .overlay, .vip-modal { display: none !important; pointer-events: none !important; }
          </style>
        </head>
        <body>
          <iframe src="${widget.url}" allow="autoplay; fullscreen; encrypted-media" allowfullscreen sandbox="allow-scripts allow-same-origin"></iframe>
        </body>
      </html>
    ''';
  }

  void _toggleFullscreen() {
    setState(() => _isFullscreen = !_isFullscreen);
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    // Garante que ao sair do player, o celular volte para o modo normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullscreen ? null : AppBar(
        title: Text(widget.titulo, style: const TextStyle(fontSize: 16)), 
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) 
            const Center(child: CircularProgressIndicator(color: Colors.greenAccent)),
          Positioned(
            bottom: 20, 
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.greenAccent.withOpacity(0.6),
              mini: true,
              onPressed: _toggleFullscreen,
              child: Icon(
                _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, 
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}