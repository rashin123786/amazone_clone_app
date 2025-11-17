import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn signIn = GoogleSignIn();
  Future<UserEntity> signInEmail(String email, String password) async {
    try {
      UserCredential cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(cred.user!);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<UserEntity> signUpEmail(String email, String password) async {
    try {
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebaseUser(cred.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<UserEntity> signInGoogle() async {
    try {
      if (kIsWeb) {
        // Web popup
        GoogleAuthProvider provider = GoogleAuthProvider();
        UserCredential cred = await _firebaseAuth.signInWithPopup(provider);
        return UserModel.fromFirebaseUser(cred.user!);
      } else {
        // Mobile flow
        final GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final cred = await FirebaseAuth.instance.signInWithCredential(
          authCredential,
        );

        return UserModel.fromFirebaseUser(cred.user!);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await signIn.signOut();
  }

  Future<UserEntity?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Future<UserEntity> updateUserProfile({
    required String name,
    required String email,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    await user?.updateDisplayName(name);
    await user?.reload();
    return UserEntity(email: email, name: name);

    // await user.updateEmail(email);
  }
}
