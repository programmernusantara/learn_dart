import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  // Kunci utama (32 karakter) untuk gembok enkripsi
  static final _key = encrypt.Key.fromUtf8('my32characterslongsecretkey12345');

  // IV (16 karakter) sebagai bumbu acak agar hasil enkripsi lebih unik
  static final _iv = encrypt.IV.fromUtf8('1234567890123456');

  // Mesin pengolah menggunakan algoritma AES
  static final _aes = encrypt.Encrypter(encrypt.AES(_key));

  /// Mengubah teks biasa menjadi kode rahasia yang tidak bisa dibaca
  static String encryptText(String text) {
    return _aes.encrypt(text, iv: _iv).base64;
  }

  /// Mengembalikan kode rahasia menjadi teks asli
  /// Jika kode salah/rusak, akan mengembalikan pesan error
  static String decryptText(String encryptedBase64) {
    try {
      return _aes.decrypt64(encryptedBase64, iv: _iv);
    } catch (e) {
      return "Pesan tidak valid atau kunci salah.";
    }
  }
}
