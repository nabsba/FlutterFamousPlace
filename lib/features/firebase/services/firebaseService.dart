import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> getDownloadURL(String fileName) async {
  try {
    // Fetch the download URL
    return await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL();
  } catch (e) {
    print('Error fetching download URL: $e'); // Log the error
    return 'Error fetching download URL: $e'; // Return empty string on error
  }
}

Future<void> deleteFile(String fileName) async {
  try {
    await FirebaseStorage.instance.ref().child(fileName).delete();
  } catch (e) {
    print(e);
  }
}

Future<void> uploadFile(
  Uint8List filePath,
  String fileName,
) async {
  try {
    await FirebaseStorage.instance.ref().child(fileName).putData(filePath);
  } catch (e) {
    print(e);
  }
}
