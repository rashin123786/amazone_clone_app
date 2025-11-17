import 'package:test/src/domain/repository/auth_repository.dart';

import '../entities/user_entity.dart';

class AuthUsecases {
  final AuthRepository repository;
  AuthUsecases(this.repository);

  Future<UserEntity> signInWithEmail(String email, String password) {
    return repository.signInWithEmail(email, password);
  }

  Future<UserEntity> signupWithEmail(String email, String password) {
    return repository.signUpWithEmail(email, password);
  }

  Future<UserEntity> signInWithGoogle() {
    return repository.signInWithGoogle();
  }

  Future<void> signOut() async {
    return repository.signOut();
  }

  Future<UserEntity?> getCurrentUser() async {
    return repository.getCurrentUser();
  }

  Future<UserEntity> updateProfile(String name, String email) {
    return repository.updateProfile(name, email);
  }
}
