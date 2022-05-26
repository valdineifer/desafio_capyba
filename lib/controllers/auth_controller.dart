import 'dart:io';

import 'package:desafio_capyba/controllers/storage_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final firebaseAuth = FirebaseAuth.instance;
  final storageController = StorageController();
  User? get currentUser {
    firebaseAuth.currentUser?.reload();
    return firebaseAuth.currentUser;
  }

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
      {required String email,
      required String password,
      required File imageFile,
      required void Function(String) onError}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String profileImageURL =
          await storageController.uploadSelfie(imageFile, onError: onError);

      if (userCredential.user != null) {
        userCredential.user?.updatePhotoURL(profileImageURL);

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
