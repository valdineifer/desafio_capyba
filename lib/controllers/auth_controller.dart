import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final firebaseAuth = FirebaseAuth.instance;

  void loginWithEmailAndPassword(
      {required String email,
      required String password,
      required void Function(String) onError,
      required void Function() onSuccess,
      required void Function(bool) toggleLoading}) async {
    try {
      toggleLoading(true);
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      toggleLoading(false);

      onSuccess();
    } catch (e) {
      onError("Não foi possível fazer login");
    }
  }

  void signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required void Function(String) onError,
      required void Function() onSuccess,
      required void Function(bool) toggleLoading}) async {
    try {
      toggleLoading(true);
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      toggleLoading(false);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'Não foi possível criar o usuário');
    }
  }
}
