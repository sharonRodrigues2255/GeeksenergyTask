import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String password;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String? profession;

  UserModel(
      {required this.userName,
      required this.password,
      required this.email,
      required this.phone,
      required this.profession});
}
