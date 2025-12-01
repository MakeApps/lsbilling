import 'package:flutter/material.dart';
import 'package:local_shout_billing/config.dart' as app_instance;

class RoleIdNotifier extends ChangeNotifier {
  int? _roleId;

  int? get roleId => _roleId;

  Future<void> loadRollId() async {
    String? roleIdString =
        await app_instance.appConfig.secureStorage.read(key: 'roleId');
    _roleId = roleIdString != null ? int.tryParse(roleIdString) : null;
    notifyListeners();
  }

  Future<void> saveRollId(int roleId) async {
    _roleId = roleId;
    await app_instance.appConfig.secureStorage
        .write(key: 'roleId', value: roleId.toString());
    notifyListeners();
  }
}

final roleIdNotifier = RoleIdNotifier();
