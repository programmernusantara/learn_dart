import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  // 1️⃣ Wajib untuk aplikasi async
  WidgetsFlutterBinding.ensureInitialized();

  // 2️⃣ Jalankan init PocketBase (menunggu SharedPreferences)
  await AuthService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 3️⃣ Cek status login dari AuthService yang sudah di-init
      home: AuthService.isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
