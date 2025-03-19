import 'package:sherpoutmobile/common/dto/user_group.dart';

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

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      group: UserGroup.values.firstWhere(
            (e) => e.name.toUpperCase() == json['group'],
        orElse: () => throw ArgumentError('Invalid UserGroup: ${json['group']}'),
      ),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      emailVerified: json['emailVerified'] as bool,
    );
  }
}