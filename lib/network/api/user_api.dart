import 'package:local_shout_billing/network/api/api.dart';

class UserApi extends Api {
  Future<dynamic> userLogin(jsonData) async {
    try {
      final userResultData =
          await requestPOST(path: '/login', parameters: jsonData).timeout(const Duration(seconds: 60));
      return userResultData;
    } catch (e, _) {
      print(e);
      print(_);
    }
  }




}
