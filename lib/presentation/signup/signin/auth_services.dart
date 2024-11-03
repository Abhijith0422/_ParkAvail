import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // The user canceled the sign-in
        return false;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user != null;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return false;
    }
  }

  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } catch (e) {
      print("Error during email sign-in: $e");
      return false;
    }
  }

  Future<bool> registerWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null;
    } catch (e) {
      print("Error during email registration: $e");
      return false;
    }
  }
}

Future<bool> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    return true;
  } catch (e) {
    print("Error while signout: $e");
    return false;
  }
}
