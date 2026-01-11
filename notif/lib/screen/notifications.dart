import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nusa/screen/notification_detail.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  @override
  void initState() {
    super.initState();
    _initNotificationLogic();
  }

  /// Inisialisasi semua skenario notifikasi (Foreground, Background, Terminated)
  Future<void> _initNotificationLogic() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 1. Ambil Token untuk keperluan pengiriman notifikasi dari server/FCM console
    String? token = await messaging.getToken();
    if (kDebugMode) print("FCM TOKEN: $token");

    // 2. FOREGROUND: Menangani pesan yang masuk saat aplikasi sedang dibuka
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotificationDialog(message);
    });

    // 3. BACKGROUND: Menangani aksi klik notifikasi saat aplikasi di belakang layar
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _navigateToDetail(message);
    });

    // 4. TERMINATED: Menangani notifikasi yang diklik saat aplikasi mati total
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _navigateToDetail(initialMessage);
    }
  }

  /// Fungsi untuk menampilkan dialog pop-up di dalam aplikasi (Foreground)
  void _showNotificationDialog(RemoteMessage message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message.notification?.title ?? "Pesan Baru"),
        content: Text(message.notification?.body ?? "Klik detail untuk melihat isi."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog sebelum pindah
              _navigateToDetail(message);
            },
            child: const Text("Lihat Detail"),
          ),
        ],
      ),
    );
  }

  /// Fungsi reusable untuk navigasi ke halaman detail
  void _navigateToDetail(RemoteMessage message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetail(
          title: message.notification?.title ?? "N/A",
          body: message.notification?.body ?? "N/A",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Warna lebih soft
      appBar: AppBar(
        title: const Text("Nusa", style: TextStyle(fontSize: 18)),
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_active_outlined, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text("Menunggu Notifikasi...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}