import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../error/services/MyLogger.dart';

Future<String> getDownloadURL(String fileName) async {
  try {
    // Fetch the download URL
    return await FirebaseStorage.instance
        .ref()
        .child(fileName)
        .getDownloadURL();
  } catch (e) {
    // Log the error
    MyLogger.logError('rror fetching download URL: $e');
    return 'Error fetching download URL: $e'; // Return empty string on error
  }
}

Future<void> deleteFile(String fileName) async {
  try {
    await FirebaseStorage.instance.ref().child(fileName).delete();
  } catch (e) {
    MyLogger.logError('deleteFile: $e');
  }
}

Future<List<String>> getAllFilesInFolder(String folderName) async {
  try {
    // Reference to the folder
    final folderRef = FirebaseStorage.instance.ref(folderName);

    // Get all files and subfolders in the folder
    final ListResult result = await folderRef.listAll();

    // Fetch download URLs for each file
    List<String> downloadURLs = await Future.wait(
      result.items.map((fileRef) async {
        return await fileRef.getDownloadURL();
      }),
    );

    return downloadURLs;
  } catch (e) {
    MyLogger.logError('Error fetching files from folder: $e');
    return []; // Return an empty list in case of error
  }
}

Future<void> uploadFile(
  Uint8List filePath,
  String fileName,
) async {
  try {
    await FirebaseStorage.instance.ref().child(fileName).putData(filePath);
  } catch (e) {
    MyLogger.logError('uploadFile: $e');
  }
}
