import 'package:flutter/material.dart';

void main() {
  runApp(const AmaroseVpnApp());
}

class AmaroseVpnApp extends StatelessWidget {
  const AmaroseVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amarose VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF6366F1),
      ),
      home: const MainVpnScreen(),
    );
  }
}

class VpnServer {
  final String country;
  final String city;
  final String flag;
  final int pingMs;
  final int loadPercentage;

  VpnServer({
    required this.country,
    required this.city,
    required this.flag,
    required this.pingMs,
    required this.loadPercentage,
  });
}

class MainVpnScreen extends StatefulWidget {
  const MainVpnScreen({super.key});

  @override
  State<MainVpnScreen> createState() => _MainVpnScreenState();
}

class _MainVpnScreenState extends State<MainVpnScreen> {
  bool isConnected = false;

  final List<VpnServer> servers = [
    VpnServer(country: 'Германия', city: 'Франкфурт', flag: '🇩🇪', pingMs: 24, loadPercentage: 35),
    VpnServer(country: 'Нидерланды', city: 'Амстердам', flag: '🇳🇱', pingMs: 31, loadPercentage: 42),
    VpnServer(country: 'США', city: 'Нью-Йорк', flag: '🇺🇸', pingMs: 110, loadPercentage: 68),
    VpnServer(country: 'Великобритания', city: 'Лондон', flag: '🇬🇧', pingMs: 45, loadPercentage: 50),
    VpnServer(country: 'Япония', city: 'Токио', flag: '🇯🇵', pingMs: 185, loadPercentage: 20),
  ];

  late VpnServer selectedServer;

  @override
  void initState() {
    super.initState();
    selectedServer = servers[0];
  }

  void _openServerList() async {
    final VpnServer? result = await showModalBottomSheet<VpnServer>(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ServerSelectionSheet(servers: servers, selected: selectedServer),
    );

    if (result != null) {
      setState(() {
        selectedServer = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CustomPaint(
                painter: AvLogoPainter(),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Amarose VPN', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Крупный логотип AV по центру
            SizedBox(
              width: 90,
              height: 90,
              child: CustomPaint(
                painter: AvLogoPainter(),
              ),
            ),
            
            const SizedBox(height: 12),
            const Text(
              'AMAROSE VPN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: Colors.white70,
              ),
            ),

            const Spacer(),

            // Кнопка выбора сервера
            GestureDetector(
              onTap: _openServerList,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  children: [
                    Text(selectedServer.flag, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${selectedServer.country} (${selectedServer.city})',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Пинг: ${selectedServer.pingMs} мс • Нагрузка: ${selectedServer.loadPercentage}%',
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Кнопка подключения
            GestureDetector(
              onTap: () {
                setState(() {
                  isConnected = !isConnected;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isConnected ? const Color(0xFF10B981) : const Color(0xFF6366F1),
                  boxShadow: [
                    BoxShadow(
                      color: (isConnected ? const Color(0xFF10B981) : const Color(0xFF6366F1)).withOpacity(0.4),
                      blurRadius: 40,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isConnected ? Icons.lock : Icons.power_settings_new,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isConnected ? 'ПОДКЛЮЧЕНО' : 'ПОДКЛЮЧИТЬ',
                      style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Статистика
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statWidget('Скачано', isConnected ? '24.5 МБ' : '0 МБ'),
                  _statWidget('Отдано', isConnected ? '4.2 МБ' : '0 МБ'),
                  _statWidget('Протокол', 'VLESS / Xray'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statWidget(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}

// Отрисовка векторного логотипа AV
class AvLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint paintA = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF818CF8), Color(0xFF6366F1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint paintV = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Отрисовка буквы A (щит сверху)
    final Path pathA = Path();
    pathA.moveTo(w * 0.2, h * 0.55);
    pathA.lineTo(w * 0.5, h * 0.15);
    pathA.lineTo(w * 0.8, h * 0.55);

    // Отрисовка перемычки A
    final Path pathBar = Path();
    pathBar.moveTo(w * 0.32, h * 0.42);
    pathBar.lineTo(w * 0.68, h * 0.42);

    // Отрисовка буквы V (вложенная снизу)
    final Path pathV = Path();
    pathV.moveTo(w * 0.25, h * 0.50);
    pathV.lineTo(w * 0.5, h * 0.85);
    pathV.lineTo(w * 0.75, h * 0.50);

    canvas.drawPath(pathA, paintA);
    canvas.drawPath(pathBar, paintA);
    canvas.drawPath(pathV, paintV);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ServerSelectionSheet extends StatelessWidget {
  final List<VpnServer> servers;
  final VpnServer selected;

  const ServerSelectionSheet({super.key, required this.servers, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Выберите локацию', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: servers.length,
              itemBuilder: (context, index) {
                final server = servers[index];
                final isSelected = server.country == selected.country;

                return ListTile(
                  leading: Text(server.flag, style: const TextStyle(fontSize: 28)),
                  title: Text('${server.country} (${server.city})'),
                  subtitle: Text('Пинг: ${server.pingMs} мс'),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Color(0xFF10B981))
                      : Text('${server.loadPercentage}%', style: const TextStyle(color: Colors.grey)),
                  onTap: () => Navigator.pop(context, server),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
