import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  static late PocketBase pb;

  /// Inisialisasi PocketBase agar login tidak hilang saat aplikasi ditutup
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final store = AsyncAuthStore(
      save: (data) => prefs.setString('pb_auth', data),
      initial: prefs.getString('pb_auth'),
      clear: () => prefs.remove('pb_auth'),
    );

    // Ganti URL ini dengan IP server PocketBase Anda
    pb = PocketBase('http://192.168.1.11:8090', authStore: store);
  }

  // Cek apakah user sudah login
  static bool get isLoggedIn => pb.authStore.isValid;
  
  // Ambil data user yang sedang login
  static RecordModel? get currentUser => pb.authStore.record;

  // Proses login via Google OAuth2
  static Future<void> loginWithGoogle() async {
    await pb.collection('users').authWithOAuth2(
      'google',
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
    );
  }

  // Logout hapus sesi
  static void logout() => pb.authStore.clear();
}