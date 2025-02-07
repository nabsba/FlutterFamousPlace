import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../error/services/MyLogger.dart';

class SecuredStorageService {
  // Create storage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Read a single value by key
  Future<String?> readValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      MyLogger.logError('readValue: $e');
      rethrow;
    }
  }

  // Read all values
  Future<Map<String, String>> readAllValues() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      MyLogger.logError('readAllValues: $e');
      rethrow;
    }
  }

  // Delete a single value by key
  Future<void> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }

  // Delete all values
  Future<void> deleteAllValues() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  // Write a value
  Future<void> writeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }
}
