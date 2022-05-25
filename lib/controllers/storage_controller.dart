import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageController {
  final storage = FirebaseStorage.instance;
  late final Reference _imagesRef;

  StorageController() {
    _imagesRef = storage.ref().child('/images');
  }

  String _getFormattedFileNameFromEmail(email, {String? filePath}) {
    final extension = filePath != null ? path.extension(filePath) : '.jpg';

    return email.replaceFirst('@', '').split('.').first + extension;
  }

  Future<void> uploadSelfie(File file, String email,
      {required Function(String) onError}) async {
    final String finalFileName =
        _getFormattedFileNameFromEmail(email, filePath: file.path);

    final imageRef = _imagesRef.child(finalFileName);

    try {
      await imageRef.putFile(file);
    } on FirebaseException catch (e) {
      onError(e.message ?? 'Erro ao fazer o carregamento da selfie');
    }
  }

  Future<String> getUserSelfieURL(String email) {
    return _imagesRef
        .child(_getFormattedFileNameFromEmail(email))
        .getDownloadURL();
  }
}
