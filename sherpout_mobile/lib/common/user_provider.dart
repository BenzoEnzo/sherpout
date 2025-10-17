import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'api/api_client.dart';
import 'dto/user_dto.dart';

class UserProvider with ChangeNotifier {
  final ApiClient _apiClient = GetIt.instance<ApiClient>();

  UserDto? _user;

  UserDto? get userData => _user;

  Future<void> fetch() async {
    Response<dynamic> response = await _apiClient.get('me');
    _user = UserDto.fromJson(response.data);
    notifyListeners();
  }

  Future<void> delete() async {
    _user = null;
    notifyListeners();
  }
}