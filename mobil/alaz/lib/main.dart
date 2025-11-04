import 'package:flutter/material.dart';
import 'ayarlar_sayfasi.dart';
import 'bluetooth_sayfasi.dart';
import 'SpeechToTextScreen.dart';

void main() {
  runApp(const SignGloveApp());
}

class SignGloveApp extends StatelessWidget {
  const SignGloveApp({super.key});

  // 🎨 Uygulama genel renk paleti
  static const Color primaryColor = Color(0xFF00BFA6); // Yeşil
  static const Color accentColor = Color(0xFF2196F3);  // Mavi
  static const Color backgroundColor = Color(0xFF0D0D0D); // Siyah
  static const Color surfaceColor = Color(0xFF1C1C1C); // Füme

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İşaret Dili Eldiveni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: accentColor,
          surface: surfaceColor,
          background: backgroundColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: surfaceColor,
          centerTitle: true,
          elevation: 2,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          color: surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 3,
          shadowColor: Colors.black54,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF111111),
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const MainBottomTabPage(),
    );
  }
}

class MainBottomTabPage extends StatefulWidget {
  const MainBottomTabPage({super.key});

  @override
  State<MainBottomTabPage> createState() => _MainBottomTabPageState();
}

class _MainBottomTabPageState extends State<MainBottomTabPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BluetoothSayfasi(),
    SpeechToTextScreen(),
    AyarlarSayfasi(),
  ];

  final List<String> _titles = [
    "Bluetooth Bağlantısı",
    "Ses Tanıma",
    "Ayarlar",
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        title: Text(_titles[_currentIndex]),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: const Border(
            top: BorderSide(color: Colors.white12, width: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 13,
            unselectedFontSize: 12,
            iconSize: 26,
            selectedItemColor: scheme.primary,
            unselectedItemColor: Colors.grey.shade600,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.bluetooth),
                label: "Bluetooth",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: "Ses",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "Ayarlar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
