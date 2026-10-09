//doesn't needed for auth instance it's always singleton

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager_firebase_assignment/common/widget/toast_meassage.dart';

class FirebaseAuthhService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? user;
  static Future<void> creteUserUsingEmailPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        print(credential.user!.email);
        credential.user!.sendEmailVerification();
        AppToast.showMessage(
          msg:
              'We have sent an email tou your ${credential.user!.email} verfied email to continue',
        );

        credential.user!.updateDisplayName(userName);
      }
    } on FirebaseAuthException catch (e) {
      AppToast.showMessage(msg: e.code);
    }
  }

  static Future<void> sigInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        if (!credential.user!.emailVerified) {
          credential.user?.sendEmailVerification();
          AppToast.showMessage(
            msg: 'You have to varified your email before signIn.',
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      AppToast.showMessage(msg: e.code);
    }
  }

  static Future<void> signInWithGooGle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    _auth.signInWithCredential(credential);
  }

  static Future<void> logOut() async {
    await _auth.signOut();
    await GoogleSignIn.instance.signOut();
  }
}
