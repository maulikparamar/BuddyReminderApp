import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  readSecuredData(String key) async {
    await storage.read(key: key);
  }

  deleteSecuredData(String key) async {
    await storage.delete(key: key);
  }
}
