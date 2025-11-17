import 'package:test/data/datasource/auth_datasource.dart';
import 'package:test/domain/repositor/auth_repository.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> signInWithEmail(String email, String password) {
    return datasource.signInEmail(email, password);
  }

  @override
  Future<UserEntity> signInWithGoogle() {
    return datasource.signInGoogle();
  }

  @override
  Future<UserEntity> signUpWithEmail(String email, String password) {
    return datasource.signUpEmail(email, password);
  }

  @override
  Future<void> signOut() {
    return datasource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() {
    return datasource.getCurrentUser();
  }

  @override
  Future<UserEntity> updateProfile(String name, String email) async {
    return datasource.updateUserProfile(name: name, email: email);
  }
}
