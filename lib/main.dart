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
      title: 'AMAROSE VPN',
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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D1424), Color(0xFF05070C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. Шапка с логотипом
              _buildHeader(),
              
              const Spacer(),

              // 2. Кнопка подключения
              _buildPowerButton(),
              
              const SizedBox(height: 25),

              // Статус
              Text(
                isConnected ? "ЗАЩИТА ВКЛЮЧЕНА" : "ЗАЩИТА ВЫКЛЮЧЕНА",
                style: TextStyle(
                  color: isConnected ? const Color(0xFF00E5FF) : Colors.white54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const Spacer(),

              // 3. Выбор сервера
              _buildServerCard(),

              const SizedBox(height: 15),

              // 4. Плашка скорости
              _buildStatsCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      // Нижняя навигация
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo_av.png',
                height: 38,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.shield,
                  color: Color(0xFF00E5FF),
                  size: 32,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'AMAROSE VPN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Российское направление',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.flash_on, color: Color(0xFF00E5FF)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPowerButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isConnected = !isConnected;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Внешнее неоновое свечение
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isConnected
                      ? const Color(0xFF00E5FF).withOpacity(0.35)
                      : Colors.transparent,
                  blurRadius: 50,
                  spreadRadius: 15,
                ),
              ],
            ),
          ),
          // Внешний ободок
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isConnected ? const Color(0xFF00E5FF) : Colors.white12,
                width: 3,
              ),
            ),
          ),
          // Внутренняя кнопка
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isConnected
                    ? [const Color(0xFF00E5FF), const Color(0xFF0088FF)]
                    : [const Color(0xFF1A2234), const Color(0xFF0F1522)],
              ),
            ),
            child: Icon(
              Icons.power_settings_new_rounded,
              size: 65,
              color: isConnected ? Colors.black : Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF121928),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bolt, color: Color(0xFF00E5FF)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Автоматический выбор',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Оптимальное соединение',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Изменить',
              style: TextStyle(color: Color(0xFF00E5FF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF121928),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.arrow_downward,
            "Загрузка",
            isConnected ? "45.2 Мб/с" : "0 Мб/с",
          ),
          Container(width: 1, height: 32, color: Colors.white10),
          _buildStatItem(
            Icons.arrow_upward,
            "Отдача",
            isConnected ? "12.8 Мб/с" : "0 Мб/с",
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00E5FF), size: 22),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0B101D),
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFF00E5FF),
      unselectedItemColor: Colors.white38,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.dns_rounded), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card_rounded), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: ''),
      ],
    );
  }
}
