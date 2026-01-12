import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';
import 'auth_service.dart';

class CallService {
  static PocketBase get pb => AuthService.pb;

  // 📋 Ambil daftar user lain
  static Future<List<RecordModel>> fetchUsers() async {
    final list = await pb.collection('users').getFullList();
    return list.where((u) => u.id != AuthService.currentUser?.id).toList();
  }

  // 🔔 Listen panggilan masuk (status: dialing)
  static void onIncomingCall(Function(RecordModel record) callback) {
    pb.collection('calls').subscribe('*', (e) {
      if (e.action != 'create') return;
      if (e.record!.getStringValue('receiver') == AuthService.currentUser?.id &&
          e.record!.getStringValue('status') == 'dialing') {
        callback(e.record!);
      }
    });
  }

  // 📞 Buat record panggil baru
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

  // 🔄 Update status (active/ended/rejected)
  static Future<void> updateStatus(String callId, String status) async {
    await pb.collection('calls').update(callId, body: {'status': status});
  }

  // 📡 Pantau perubahan status (Kunci sinkronisasi A & B)
  static void watchCallStatus(String callId, Function(String status) callback) {
    pb.collection('calls').subscribe(callId, (e) {
      if (e.record != null) callback(e.record!.getStringValue('status'));
    });
  }

  // 🔑 Ambil Token dari Backend Go
  static Future<String?> getLiveKitToken(String room) async {
    // ⚠️ Gunakan IP Laptop, tambahkan parameter user
    final userId = AuthService.currentUser?.id;
    final url =
        'http://192.168.1.11:8090/api/livekit/token?room=$room&user=$userId';

    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {'Authorization': pb.authStore.token},
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['token'];
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Network Error: $e");
      }
      return null;
    }
  }

  static void stop(String id) => pb.collection('calls').unsubscribe(id);
}
