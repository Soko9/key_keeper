import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import '../../../app_secrets.dart';

abstract class EncryptionHelper {
  static String encrypt(String pass) {
    final cipher = Cipher(secretKey: AppSecrets.encryptionKey);
    final encrypted = cipher.xorEncode(pass);
    return encrypted;
  }

  static String decrypt(String pass) {
    final cipher = Cipher(secretKey: AppSecrets.encryptionKey);
    final decrypted = cipher.xorDecode(pass);
    return decrypted;
  }
}
