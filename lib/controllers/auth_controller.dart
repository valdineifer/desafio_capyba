import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithEmailAndPassword(
      {required String email,
      required String password,
      required void Function(String) onError,
      required void Function() onSuccess}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError("Não foi possível fazer login. Verifique os dados informados.");
    }
  }

  Future<void> signUpWithEmailAndPassword(
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

  Future<bool> isLoggedIn() async {
    await firebaseAuth.currentUser?.reload();
    return firebaseAuth.currentUser != null;
  }

  Future<void> logout({required void Function() onSuccess}) async {
    await firebaseAuth.signOut();

    onSuccess();
  }
}
