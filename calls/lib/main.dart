import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nusa/screen/notifications.dart';
import 'firebase_options.dart';

// Fungsi global untuk menangani pesan saat aplikasi di background/terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Menangani pesan background: ${message.messageId}");
  }
}

void main() async {
  // Pastikan binding Flutter sudah siap sebelum inisialisasi Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Daftarkan handler untuk kondisi latar belakang
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusa App',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const NotificationScreen(),
    );
  }
}