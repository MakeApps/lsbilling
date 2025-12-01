import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';

class Authentication extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool isLogin = false;

  checkLogin() async {
    final token = await _storage.read(key: 'token');
    isLogin = (token == null) ? false : true;
    notifyListeners();
    return isLogin;
  }

  bool get loggedIn => isLogin;
}
