import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageService {
  // Create storage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Read a single value by key
  Future<String?> readValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      print('Error reading value: $e');
      rethrow;
    }
  }

  // Read all values
  Future<Map<String, String>> readAllValues() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      print('Error reading all values: $e');
      rethrow;
    }
  }

  // Delete a single value by key
  Future<void> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print('Error deleting value: $e');
      rethrow;
    }
  }

  // Delete all values
  Future<void> deleteAllValues() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('Error deleting all values: $e');
      rethrow;
    }
  }

  // Write a value
  Future<void> writeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      print('Error writing value: $e');
      rethrow;
    }
  }
}
