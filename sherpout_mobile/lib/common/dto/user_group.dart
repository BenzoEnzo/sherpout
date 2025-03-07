import 'package:sherpoutmobile/common/dto/user_dto.dart';

class UserDto {
  String id;
  UserGroup group;
  String firstName;
  String lastName;
  String email;
  bool emailVerified;

  UserDto({
    required this.id,
    required this.group,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerified,
  });
}