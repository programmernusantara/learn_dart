import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../services/auth_service.dart';
import '../services/call_service.dart';
import 'call_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RecordModel> users = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    // Standby menunggu panggilan masuk
    CallService.onIncomingCall((record) => _showIncomingDialog(record));
  }

  void _loadData() async {
    final list = await CallService.fetchUsers();
    setState(() => users = list);
  }

  void _showIncomingDialog(RecordModel record) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("Panggilan Masuk"),
        content: const Text("Ada panggilan video untuk Anda."),
        actions: [
          TextButton(
            onPressed: () {
              CallService.updateStatus(record.id, 'rejected');
              Navigator.pop(ctx);
            },
            child: const Text("Tolak", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              CallService.updateStatus(record.id, 'active');
              Navigator.pop(ctx);
              _openCall(record.getStringValue('room'));
            },
            child: const Text("Terima"),
          ),
        ],
      ),
    );
  }

  void _startCall(RecordModel target) async {
    final roomName = "room_${AuthService.currentUser!.id}_${target.id}";
    final record = await CallService.startCallRecord(target.id, roomName);

    // Pantau apakah dia menerima
    CallService.watchCallStatus(record.id, (status) {
      if (status == 'active') {
        CallService.stop(record.id);
        _openCall(roomName);
      } else if (status == 'rejected') {
        CallService.stop(record.id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ditolak")));
      }
    });
  }

  void _openCall(String room) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(roomName: room)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Call App")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(users[i].getStringValue('name')),
          trailing: IconButton(
            icon: const Icon(Icons.videocam, color: Colors.blue),
            onPressed: () => _startCall(users[i]),
          ),
        ),
      ),
    );
  }
}