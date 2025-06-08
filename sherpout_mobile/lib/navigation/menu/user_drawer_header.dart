import 'package:flutter/material.dart';

class UserDrawerHeader extends StatelessWidget {
  final String name;
  final String lastName;
  final String accountEmail;

  const UserDrawerHeader({
    super.key,
    required this.name,
    required this.lastName,
    required this.accountEmail
  });

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      accountName: Text(name.isNotEmpty && lastName.isNotEmpty ? "$name $lastName" : ''),
      accountEmail: Text(accountEmail.isNotEmpty ? accountEmail : ''),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Text(
          name.isNotEmpty ? name.characters.first.toUpperCase() : '',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}