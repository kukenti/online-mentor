import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

abstract class ImageRepository {
  Future<String> uploadImage(File imageFile, String folderName);
}

@Injectable(as: ImageRepository)
class FirestoreImageRepository implements ImageRepository {
  @override
  Future<String> uploadImage(File imageFile, String folderName) async {
    try {
      final fileName = path.basename(imageFile.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('$folderName/$fileName');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Failed to upload image: $error');
      return '';
    }
  }
}
