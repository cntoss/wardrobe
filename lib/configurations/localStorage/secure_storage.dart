import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final secureStorage = FlutterSecureStorage();

  void setLocalValue({required String key, required String value}) {
    secureStorage.write(key: key, value: value);
  }

  Future<String?> getLocalValue({required String key}) async {
    return await secureStorage.read(key: key);
  }

  Future<Map<String, String>> getAllLocalValue() async {
    return await secureStorage.readAll();
  }

  deleteLocalValue({required String key}) async {
    return await secureStorage.delete(key: key);
  }

  deleteAllLocalValue() async {
    return await secureStorage.deleteAll();
  }
}
