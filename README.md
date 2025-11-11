Akıllı İşaret Dili Eldiveni

ESP32 ve çoklu IMU sensörleri ile el/parmak hareketlerini gerçek zamanlı okuyup, makine öğrenmesi ve graf veritabanı ile işaret dilini metne dönüştüren akıllı eldiven sistemi.

Amaç sadece hareketi algılamak değil; aynı zamanda bağlamı anlamak:

“Bu hangi işaret?” ve hemen ardından “Bu işaretten sonra ne gelmeli?” sorularına cevap veren uçtan uca bir mimari.


![WhatsApp Görsel 2025-11-11 saat 14 07 31_5566cba0](https://github.com/user-attachments/assets/baa1fbd9-555c-4876-88f5-09dfc08e2132)
![WhatsApp Görsel 2025-11-11 saat 14 07 32_8455daf2](https://github.com/user-attachments/assets/e1f8fb3f-c787-4749-accd-bce367968204)
![WhatsApp Görsel 2025-11-11 saat 14 07 33_dee3fa83](https://github.com/user-attachments/assets/acb7973d-13a1-4fd7-a03e-eb2a33cfdcb1)

🔧 Donanım Özeti
	•	Esnek eldiven üzerine:
	•	El üstünde 1× 10-DoF IMU
	•	Parmak eklemlerinde birden fazla 6-DoF IMU
	•	Tüm sensörler ESP32 üzerinden I²C ile okunur.
	•	Gerekirse I²C çoklayıcı kullanılır.
	•	Sensörler için hafif 3B baskı yuvalar.
	•	Güç: Li-Po batarya
	•	Son dokunuş: Kablolama, sabitleme, montaj sonrası her sensörün adres ve iletişim testi.


🧠 Sistem Mimarisi 
	1.	Tanımlayıcı Katman (Interpreter)
Eldivenden gelen sensör verisini işleyip “Bu hangi işaret?” sorusunu yanıtlar.
	2.	Bağlamsal Katman (Contextual – Neo4J)
Tanınan işaretleri graf yapısında ilişkilendirir:
	•	Olası sonraki işaretleri tahmin eder.
	•	Cümlenin dil bilgisel tutarlılığını kontrol eder.
	3.	GraphQL API Katmanı
FastAPI + GraphQL ile tüm sistemi tek uçtan dış dünyaya açar (web, mobil, dashboard).


🚀 Çalışma Prensibi
	•	ESP32, her IMU için cihaz üzerinde sensör füzyonu (ör. Madgwick) uygular.
	•	Tüm sensörlerin yönelim verileri belirli aralıklarla JSON paketine dönüştürülür:
	•	timestamp, el üstü IMU, parmak IMU listesi vb.
	•	JSON verisi Wi-Fi üzerinden MQTT veya WebSocket ile backend’e iletilir.
	•	Python backend:
	•	Gelen akışı sabit uzunluklu pencerelere böler.
	•	LSTM / Transformer modeli ile hangi işaretin yapıldığını tahmin eder.
	•	Tahmin edilen işaret, Neo4J üzerinde:
	•	NEXT_SIGN ilişkileri ile analiz edilir.
	•	Örneğin "Ben" işaretinden sonra gelebilecek en olası 5 işaret sorgulanır.
	•	Sonuçlar:
	•	Metin çıktısı
	•	Önerilen sonraki işaretler
	•	İstenirse 3B el modeliyle görsel gösterim.


🧩 Teknolojiler
Donanım
	•	ESP32
	•	10-DoF & 6-DoF IMU’lar
	•	I²C çoklayıcı, Li-Po batarya, 3B baskı sensör yuvaları

Yazılım & Backend
	•	C++ / Arduino (eldiven yazılımı)
	•	Python
	•	FastAPI
	•	GraphQL (Strawberry / Ariadne)
	•	MQTT veya WebSocket

Veri & Yapay Zekâ
	•	TensorFlow (Keras) veya PyTorch
	•	LSTM / Transformer tabanlı modeller
	•	Neo4J (graf veritabanı, Sign ve NEXT_SIGN ilişkileri)


📚 Model & Veri
	•	Her işaret için çoklu kullanıcıdan tekrar edilen sensör kayıtları.
	•	Denetimli öğrenme ile işaret tanıma modeli eğitimi.
	•	Türk İşaret Dili istatistikleri ile Neo4J grafının otomatik doldurulması.
	•	Sonuç: Hareket → İşaret → Anlam → Tahmin zincirini yöneten akıllı sistem.
