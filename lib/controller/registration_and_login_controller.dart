import 'package:flutter_application_4/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegistraionAndLoginController {
  final mydb = Hive.box<UserModel>("USER");

  addUserInfo(UserModel value) {
    mydb.put(value.userName, value);
  }
}
