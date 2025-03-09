import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/user_group.dart';

import 'api_client.dart';

class UserProvider with ChangeNotifier {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  UserDto? _user;

  UserDto? get userData => _user;

  Future<void> fetch() async {
    //TODO notify listeners
    _apiClient.get('me').then((response) => _fetchUser(response));
  }

  Future<void> delete() async {
    _user = null;
    notifyListeners();
  }

  void _fetchUser(Response<dynamic> response) {
    _user = jsonDecode(response.data);
    notifyListeners();
  }
}