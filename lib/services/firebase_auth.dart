import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool> logIn() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      if (userCredential.user?.uid != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      await firebaseAuth.signOut();
      final userCredential = firebaseAuth.currentUser;
      if (userCredential == null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
