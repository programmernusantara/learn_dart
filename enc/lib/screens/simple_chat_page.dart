import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../services/pb_service.dart';
import '../services/encryption_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Kontroler untuk membaca teks dari input field
  final TextEditingController _textController = TextEditingController();

  // Aksi saat tombol kirim ditekan
  void _handleSend() {
    PocketBaseService.sendMessage(_textController.text);
    _textController.clear(); // Bersihkan kolom input setelah kirim
  }

  @override
  void dispose() {
    // Bersihkan resource saat halaman ditutup agar tidak memory leak
    PocketBaseService.stopRealtime();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp')),
      body: Column(
        children: [
          // Widget untuk menampilkan daftar pesan secara realtime
          Expanded(
            child: StreamBuilder<List<RecordModel>>(
              stream:
                  PocketBaseService.getMessageStream(), // Sumber data stream
              builder: (context, snapshot) {
                // Tampilkan loading spinner jika data belum siap
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final semuaPesan = snapshot.data!;

                return ListView.builder(
                  reverse: true, // Membalik arah: pesan terbaru di bawah
                  itemCount: semuaPesan.length,
                  itemBuilder: (context, index) {
                    final item = semuaPesan[index];

                    // Ambil data pesan yang masing di enkripsi
                    final sender = item.getStringValue('content');

                    // Mengubah pesan yang dienkripsi menjadi pesan asli
                    final receiver = EncryptionHelper.decryptText(sender);
                    return ListTile(
                      title: Text(receiver),
                      subtitle: Text(
                        item.getStringValue('created'), // Info waktu kirim
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Area input teks di bagian bawah
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis sesuatu...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _handleSend, // Jalankan fungsi kirim
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
