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
    print('Error fetching files from folder: $e'); // Log the error
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
    print(e);
  }
}
