import 'package:recipe_cart/common/services/user_api_service.dart';
import 'package:recipe_cart/models/ModelProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userAPIService = ref.read(userAPIServiceProvider);
  return UserRepository(userAPIService);
});


class UserRepository {
  UserRepository(this.userAPIService);

  final UserAPIService userAPIService;

  Future<void> signOut() {
    return userAPIService.signOutCurrentUser();
  }

  Future<void> signUpUser({required String username, required String password, required String email, String? phoneNumber}) {
    return userAPIService.signUpUser(username: username, password: password, email: email, phoneNumber: phoneNumber);
  }

  

}