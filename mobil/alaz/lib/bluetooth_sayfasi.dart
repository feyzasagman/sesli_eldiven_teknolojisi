import 'package:flutter/material.dart';

class BluetoothSayfasi extends StatefulWidget {
  const BluetoothSayfasi({super.key});

  @override
  State<BluetoothSayfasi> createState() => _BluetoothSayfasiState();
}

class _BluetoothSayfasiState extends State<BluetoothSayfasi> {
  List<String> cihazlar = [];
  bool scanning = false;

  // 🎨 Yeşil - Mavi - Füme - Siyah Paleti
  static const Color primaryColor = Color(0xFF00BFA6); // Yeşil
  static const Color accentColor = Color(0xFF2196F3);  // Mavi
  static const Color surfaceColor = Color(0xFF1C1C1C); // Füme
  static const Color backgroundColor = Color(0xFF0D0D0D); // Siyah
  static const Color textColor = Colors.white70;

  void tara() async {
    setState(() {
      scanning = true;
      cihazlar.clear();
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      cihazlar = [
        "Eldiven Sensör - Sol El",
        "Eldiven Sensör - Sağ El",
        "Akıllı Bileklik 3"
      ];
      scanning = false;
    });
  }

  void baglan(String cihaz) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$cihaz ile bağlantı kuruluyor..."),
        backgroundColor: primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tara();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 🔍 Tarama Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: scanning ? null : tara,
                icon: scanning
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.search, color: Colors.white),
                label: Text(
                  scanning ? "Taranıyor..." : "Cihazları Tara",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Cihaz Listesi
            Expanded(
              child: cihazlar.isEmpty
                  ? Center(
                child: Text(
                  scanning
                      ? "Cihazlar aranıyor..."
                      : "Hiçbir cihaz bulunamadı.",
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: cihazlar.length,
                itemBuilder: (context, index) {
                  var cihaz = cihazlar[index];
                  return Card(
                    color: surfaceColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundColor:
                        accentColor.withOpacity(0.15),
                        child:
                        Icon(Icons.bluetooth, color: accentColor),
                      ),
                      title: Text(
                        cihaz,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: const Text(
                        "Cihaz ID: XXX-XXX",
                        style: TextStyle(color: Colors.white54),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => baglan(cihaz),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        child: const Text(
                          "Bağlan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
