import 'package:flutter/material.dart';

void main() {
  runApp(const GlobalVpnApp());
}

class GlobalVpnApp extends StatelessWidget {
  const GlobalVpnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global VPN',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B101D),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B101D),
              Color(0xFF05070C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const Spacer(),
              _buildConnectButton(),
              const SizedBox(height: 20),
              Text(
                isConnected ? "ПОДКЛЮЧЕНО" : "ЗАЩИТА ВЫКЛЮЧЕНА",
                style: TextStyle(
                  color: isConnected ? const Color(0xFF00E5FF) : Colors.white54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              _buildStatsCards(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo_av.png',
                height: 36,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.shield,
                  color: Color(0xFF00E5FF),
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'GLOBAL VPN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.shield_outlined, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isConnected = !isConnected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF121929),
          boxShadow: [
            BoxShadow(
              color: isConnected
                  ? const Color(0xFF00E5FF).withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
          border: Border.all(
            color: isConnected ? const Color(0xFF00E5FF) : Colors.white12,
            width: 3,
          ),
        ),
        child: Icon(
          Icons.power_settings_new_rounded,
          size: 70,
          color: isConnected ? const Color(0xFF00E5FF) : Colors.white38,
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
                Icons.arrow_downward, "Загрузка", isConnected ? "45.2 Мб/с" : "0 Мб/с"),
            Container(width: 1, height: 30, color: Colors.white10),
            _buildStatItem(
                Icons.arrow_upward, "Отдача", isConnected ? "12.8 Мб/с" : "0 Мб/с"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00E5FF), size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white38, fontSize: 11)),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
