import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  late final Reference _imagesRef;
  late final Reference _storageRef;

  StorageService() {
    _storageRef = _storage.ref();
    _imagesRef = _storageRef.child('/images');
  }

  String _getFormattedFileName(String filePath) {
    return Uuid().v4() + path.extension(filePath);
  }

  Future<String> uploadSelfie(File file,
      {required Function(String) onError}) async {
    final String finalFileName = _getFormattedFileName(file.path);

    final imageRef = _imagesRef.child(finalFileName);

    try {
      await imageRef.putFile(file);
    } on FirebaseException catch (e) {
      onError(e.message ?? 'Erro ao fazer o carregamento da selfie');
    }

    return imageRef.getDownloadURL();
  }

  Future<String> getUserSelfieURL(String url) {
    return _storageRef.child(url).getDownloadURL();
  }
}
