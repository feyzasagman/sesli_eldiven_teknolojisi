import 'package:flutter/material.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool isNotificationEnabled = true;
  bool isDarkMode = false;
  String appVersion = "1.0.1";

  // 🎨 Renk paleti
  final Color primaryColor = Colors.tealAccent.shade400; // 🟩 Yeşil
  final Color accentColor = Colors.lightBlueAccent.shade100; // 🔵 Mavi vurgu
  final Color backgroundColor = const Color(0xFF1E1E1E); // ⚫ Füme (arka plan)
  final Color cardColor = const Color(0xFF2A2A2A); // 🧱 Koyu gri kart
  final Color textColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // 👤 Profil Kartı
          Card(
            color: cardColor,
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: primaryColor.withOpacity(0.2),
                child: Icon(Icons.person, color: primaryColor, size: 28),
              ),
              title: const Text(
                "Cihan Gaspak",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text("Prototip Kullanıcı",
                  style: TextStyle(color: accentColor)),
              trailing: Icon(Icons.edit, color: primaryColor),
              onTap: () => _showSnackBar("Profil düzenleme (prototip)"),
            ),
          ),

          const Divider(color: Colors.white24, thickness: 1),

          _buildSectionTitle("Genel Ayarlar"),
          _buildSwitchTile(
            icon: Icons.notifications,
            title: "Bildirimler",
            subtitle: "Bildirim tercihlerini düzenleyin",
            value: isNotificationEnabled,
            onChanged: (v) => setState(() => isNotificationEnabled = v),
          ),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: "Karanlık Mod",
            subtitle: "Uygulama temasını değiştirin",
            value: isDarkMode,
            onChanged: (v) => setState(() => isDarkMode = v),
          ),
          _buildListTile(
            icon: Icons.language,
            title: "Dil",
            subtitle: "Uygulama dilini değiştirin",
            onTap: () => _showSnackBar('Dil değişimi henüz desteklenmiyor!'),
          ),

          const Divider(color: Colors.white24),
          _buildSectionTitle("Ek Ayarlar"),
          _buildListTile(
            icon: Icons.star,
            title: "Bizi Değerlendir",
            subtitle: "Google Play üzerinden puan verin",
            onTap: _openPlayStore,
          ),
          _buildListTile(
            icon: Icons.email,
            title: "Bize Ulaşın",
            subtitle: "Öneri ve geri bildirim gönderin",
            onTap: _sendEmail,
          ),

          const SizedBox(height: 20),

          // 🔹 Hakkında Bölümü
          _buildSectionTitle("Hakkında"),
          _buildInfoCard(
            icon: Icons.handshake,
            title: "İşaret Dili Eldiveni Uygulaması",
            content:
            "Bu proje, konuşma engelli bireylerin iletişimini kolaylaştırmak amacıyla geliştirilmiştir.\n"
                "Geliştirici: Cihan Gaspak\nVersiyon: $appVersion",
          ),
          _buildInfoCard(
            icon: Icons.memory,
            title: "Kullanılan Teknolojiler",
            content:
            "• Flutter ile mobil uygulama geliştirme\n"
                "• Sensör verisi işleme ve Bluetooth bağlantısı\n"
                "• Yapay zeka ile işaret dilinin sese çevrilmesi",
          ),
          _buildInfoCard(
            icon: Icons.group,
            title: "Proje Ekibi",
            content:
            "👩‍💼 Feyza Sağman — Scrum Master / AI\n"
                "👨‍💻 Muhammet Hasan Uyar — Backend / API\n"
                "🧠 Kübra Demirgüç — Veri İşleme\n"
                "🔧 Fatih Gülcü — Donanım Katmanı\n"
                "📱 Cihan Gaspak — Mobil Geliştirme",
          ),
          _buildInfoCard(
            icon: Icons.contact_mail,
            title: "İletişim",
            content:
            "📧 Mail: destek@alazla.com\n"
                "🌐 Web: www.alazla.com.tr\n"
                "© 2025 Cihan Gaspak",
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      activeColor: primaryColor,
      inactiveThumbColor: Colors.grey.shade600,
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: primaryColor),
      title: Text(title,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, size: 28, color: primaryColor),
        title: Text(title,
            style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: textColor)),
        trailing:
        Icon(Icons.arrow_forward_ios, size: 16, color: accentColor),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      color: cardColor,
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.15),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, size: 26, color: primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: accentColor)),
                  const SizedBox(height: 6),
                  Text(content,
                      style: TextStyle(
                          fontSize: 15, color: textColor, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: accentColor)),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _openPlayStore() => _showSnackBar("Play Store açılacak (prototip).");
  void _sendEmail() => _showSnackBar("Mail gönderilecek (prototip).");
}
