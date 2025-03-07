import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/user_group.dart';

import 'api_client.dart';

class UserProvider with ChangeNotifier {
  UserDto? _user;

  UserDto? get userData => _user;

  Future<void> fetch() async {
    //TODO notify listeners
    ApiClient.get('me')
        .then((response) => _user = jsonDecode(response.data))
        .catchError((ignored) => print("error"));
  }

  Future<void> delete() async {
    _user = null;
    notifyListeners();
  }
}