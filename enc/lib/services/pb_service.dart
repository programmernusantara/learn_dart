import 'dart:async';
import 'package:pocketbase/pocketbase.dart';
import 'encryption_helper.dart';

class PocketBaseService {
  // Inisialisasi koneksi ke server PocketBase
  static final pb = PocketBase('http://127.0.0.1:8090');

  // Mengambil aliran data (Stream) pesan secara realtime
  static Stream<List<RecordModel>> getMessageStream() async* {
    // 1. Ambil data historis (50 pesan terakhir) dari koleksi 'messages'
    final initialFetch = await pb
        .collection('messages')
        .getList(sort: '-created', perPage: 50);

    List<RecordModel> listPesan = initialFetch.items;

    // 2. Kirim data awal ke UI agar chat tidak kosong saat dibuka
    yield listPesan;

    // 3. Buat controller untuk mengelola aliran data tambahan
    final controller = StreamController<List<RecordModel>>();

    // 4. Berlangganan (Subscribe) ke perubahan data di server
    pb.collection('messages').subscribe('*', (dataServer) {
      // Jika terdeteksi ada data baru yang dibuat ('create')
      if (dataServer.action == 'create') {
        // Masukkan pesan baru tersebut ke posisi paling atas list
        listPesan.insert(0, dataServer.record!);
        // Update aliran data agar UI melakukan render ulang
        controller.add(List.from(listPesan));
      }
    });

    // Menghubungkan aliran controller ke output fungsi
    yield* controller.stream;
  }

  // Fungsi untuk mengirim pesan baru ke server
  static Future<void> sendMessage(String isiPesan) async {
    if (isiPesan.trim().isEmpty) return; // Validasi: abaikan jika teks kosong

    // 1. Enkripsi pesan sebelum menyimpannya ke server
    final encryptedMessag = EncryptionHelper.encryptText(isiPesan);

    // 2. Kirim pesan yang sudah di enkripsi ke server
    await pb.collection('messages').create(body: {'content': encryptedMessag});
  }

  // Fungsi untuk memutus koneksi realtime (Optimasi RAM & Baterai)
  static void stopRealtime() => pb.collection('messages').unsubscribe('*');
}
