import 'package:flutter_boilerplate/feature/auth/model/auth_state.dart';
import 'package:flutter_boilerplate/feature/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/token/repository/token_repository.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(ref);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this._ref) : super(const AuthState.initial()) {}

  final Ref _ref;
  late final AuthRepository _loginRepository = _ref.read(authRepositoryProvider);
  late final TokenRepository _tokenRepository = _ref.read(tokenRepositoryProvider);

  Future<void> login(String email, String password) async {
    state = await _loginRepository.login(email, password);
  }

  Future<void> signUp(String name, String email, String password) async {
    state = await _loginRepository.signUp(name, email, password);
  }

  Future<void> logout() async {
    await _tokenRepository.remove();
    state = const AuthState.initial();
  }
}
