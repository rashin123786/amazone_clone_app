import 'package:flutter/material.dart';
import 'package:test/domain/usecases/auth_usecases.dart';
import '../../../domain/entities/user_entity.dart';

class AuthController with ChangeNotifier {
  final AuthUsecases authUsecases;

  UserEntity? currentUser;
  bool isLoading = false;

  AuthController(this.authUsecases);

  Future<String?> signInEmailAuth(String email, String pass) async {
    _setLoading(true);
    try {
      currentUser = await authUsecases.signInWithEmail(email, pass);
      return null; // no error
    } catch (e) {
      return e.toString(); // return error
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signUpEmailAuth(String email, String pass) async {
    _setLoading(true);
    try {
      currentUser = await authUsecases.signupWithEmail(email, pass);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      currentUser = await authUsecases.signInWithGoogle();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await authUsecases.signOut();
    currentUser = null;
    notifyListeners();
  }

  Future<void> updateProfile(String name, String email) async {
    _setLoading(true);
    try {
      currentUser = await authUsecases.updateProfile(name, email);
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
