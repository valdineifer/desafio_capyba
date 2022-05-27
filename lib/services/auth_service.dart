import 'dart:io';

import 'package:desafio_capyba/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final userStream = FirebaseAuth.instance.authStateChanges();

  final _storageService = StorageService();

  Future<void> loginWithEmailAndPassword(
      {required String email,
      required String password,
      required void Function(String) onError}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      onError(e.message ??
          "Não foi possível fazer login. Verifique os dados informados.");
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password,
      required File imageFile,
      required void Function(String) onError}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String profileImageURL =
          await _storageService.uploadSelfie(imageFile, onError: onError);

      if (userCredential.user != null) {
        await userCredential.user?.updatePhotoURL(profileImageURL);
        await userCredential.user?.updateDisplayName(name);
        await userCredential.user?.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'Não foi possível criar o usuário');
    }
  }

  Future<bool> isLoggedIn() async {
    await firebaseAuth.currentUser?.reload();
    return firebaseAuth.currentUser != null;
  }

  Future<void> logout({required void Function() onSuccess}) async {
    await firebaseAuth.signOut();

    onSuccess();
  }
}
