import 'package:flutter/material.dart';
import 'screens/simple_chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketBase Chat',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatScreen(), // Halaman utama aplikasi
    );
  }
}
