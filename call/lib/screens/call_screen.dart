import 'package:flutter/material.dart';
import 'package:livekit_components/livekit_components.dart';
import '../services/call_service.dart';

class CallScreen extends StatefulWidget {
  final String roomName;
  const CallScreen({super.key, required this.roomName});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  void _connect() async {
    final token = await CallService.getLiveKitToken(widget.roomName);
    if (token == null) {
      if (mounted) Navigator.pop(context);
      return;
    }
    setState(() => _token = token);

    // Jika lawan bicara mematikan telepon
    CallService.watchCallStatus('*', (status) {
      if (status == 'ended' && mounted) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    CallService.stop('*');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_token == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return LivekitRoom(
      roomContext: RoomContext(
        url: 'ws://192.168.1.11:7880', // IP Server LiveKit
        token: _token!,
        connect: true,
        onDisconnected: () {
          CallService.updateStatus(widget.roomName, 'ended'); // Sederhanakan logikanya
          if (mounted) Navigator.pop(context);
        },
      ),
      builder: (context, roomCtx) => Scaffold(
        body: Stack(
          children: [
            ParticipantLoop(participantTrackBuilder: (_, _) => const VideoTrackWidget()),
            const Positioned(bottom: 30, left: 0, right: 0, child: ControlBar()),
          ],
        ),
      ),
    );
  }
}