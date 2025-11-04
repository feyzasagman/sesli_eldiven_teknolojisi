import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  double _confidence = 1.0;
  String _currentText = '🎙️ Mikrofona dokunarak konuşmaya başlayın...';
  List<String> _history = [];

  // 🎨 Renk paleti
  static const Color primaryBlue = Color(0xFF1976D2); // Mavi
  static const Color accentGreen = Color(0xFF43A047); // Yeşil
  static const Color darkGrey = Color(0xFF121212); // Siyah-füme
  static const Color surfaceGrey = Color(0xFF1E1E1E);
  static const Color textColor = Colors.white70;

  @override
  void initState() {
    super.initState();
    _initSpeechState();
  }

  Future<void> _initSpeechState() async {
    bool available = await _speech.initialize(
      onError: (val) => debugPrint('Hata: $val'),
      onStatus: (val) => debugPrint('Durum: $val'),
    );
    if (!available) {
      setState(() {
        _currentText = "❌ Konuşma tanıma servisi kullanılamıyor.";
      });
    }
  }

  Future<void> _startListening() async {
    if (_speech.isAvailable && !_isListening) {
      setState(() => _isListening = true);
      await _speech.listen(
        listenFor: const Duration(minutes: 1),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: 'tr_TR',
        listenMode: stt.ListenMode.dictation,
        onResult: (val) {
          setState(() {
            _currentText = val.recognizedWords;
            if (val.finalResult && _currentText.trim().isNotEmpty) {
              _history.insert(0, _currentText);
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          });
        },
      );
    }
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🎙️ Mikrofon Düğmesi (artık üstte ve daha küçük)
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _isListening ? _stopListening : _startListening,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _isListening ? 85 : 70,
                  height: _isListening ? 85 : 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: _isListening
                          ? [accentGreen.withOpacity(0.8), primaryBlue.withOpacity(0.8)]
                          : [primaryBlue.withOpacity(0.4), Colors.grey.withOpacity(0.2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _isListening
                            ? accentGreen.withOpacity(0.5)
                            : primaryBlue.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening ? Icons.hearing : Icons.mic_none,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔊 Konuşma metni
            Container(
              padding: const EdgeInsets.all(14),
              width: double.infinity,
              decoration: BoxDecoration(
                color: surfaceGrey.withOpacity(0.9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _isListening ? accentGreen.withOpacity(0.6) : Colors.grey.shade800,
                  width: 1.2,
                ),
              ),
              child: Text(
                _currentText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Güven Oranı: ${(_confidence * 100.0).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),

            const SizedBox(height: 18),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Geçmiş',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _history.isEmpty
                  ? const Center(
                child: Text(
                  'Henüz geçmiş yok.',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                ),
              )
                  : ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item = _history[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: surfaceGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade800,
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.3,
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
