import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'auth_service.dart';

class CallService {
  static PocketBase get pb => AuthService.pb;

  static Future<List<RecordModel>> fetchUsers() async {
    final list = await pb.collection('users').getFullList();
    return list.where((u) => u.id != AuthService.currentUser?.id).toList();
  }

  // Mendengarkan panggilan masuk
  static void onIncomingCall(Function(RecordModel record) callback) {
    pb.collection('calls').subscribe('*', (e) {
      if (e.action != 'create') return;
      if (e.record!.getStringValue('receiver') == AuthService.currentUser?.id &&
          e.record!.getStringValue('status') == 'dialing') {
        callback(e.record!);
      }
    });
  }

  // Memulai panggilan
  static Future<RecordModel> startCallRecord(
    String targetId,
    String room,
  ) async {
    return await pb
        .collection('calls')
        .create(
          body: {
            'caller': AuthService.currentUser!.id,
            'receiver': targetId,
            'room': room,
            'status': 'dialing',
          },
        );
  }

  // Update status ke 'active' atau 'ended'
  static Future<void> updateStatus(String callId, String status) async {
    await pb.collection('calls').update(callId, body: {'status': status});
  }

  // Pantau status record tertentu (Kunci agar kedua pihak keluar bareng)
  static void watchCallStatus(String callId, Function(String status) callback) {
    pb.collection('calls').subscribe(callId, (e) {
      if (e.record != null) {
        callback(e.record!.getStringValue('status'));
      }
    });
  }

  static Future<String?> getLiveKitToken(String room) async {
    // Sesuaikan URL backend Anda
    final url =
        'http://127.0.0.1:8090/api/livekit/token?room=$room&user=${AuthService.currentUser?.id}';
    try {
      final res = await http.get(Uri.parse(url));
      return res.statusCode == 200 ? jsonDecode(res.body)['token'] : null;
    } catch (_) {
      return null;
    }
  }

  static void stop(String id) => pb.collection('calls').unsubscribe(id);
}
