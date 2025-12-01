import 'package:local_shout_billing/network/api/user_api.dart';
import 'package:local_shout_billing/network/repositories/repository.dart';

class AuthenticationRepo extends Repository {
  Future<dynamic> submitLoginForm(jsonData) async =>
      await UserApi().userLogin(jsonData);

}
