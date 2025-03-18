import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AuthService {
  final String clientId = dotenv.env['KEYCLOAK_CLIENT_ID']!;
  final String redirectUrl = dotenv.env['KEYCLOAK_REDIRECT_URL']!;
  final String issuer = dotenv.env['KEYCLOAK_URL']!;

  final FlutterAppAuth _appAuth;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._appAuth, this._secureStorage);

  Future<void> login(BuildContext context) async {
    final AuthorizationTokenResponse result =
        await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(clientId, redirectUrl,
          issuer: issuer,
          scopes: ['openid', 'profile', 'email'],
          allowInsecureConnections: true),
    );

    await _saveTokens(result);
  }

  Future<void> refreshToken() async {
    final TokenResponse result = await _appAuth.token(
      TokenRequest(clientId, redirectUrl,
          discoveryUrl: '$issuer/.well-known/openid-configuration',
          refreshToken: await _secureStorage.read(key: 'refresh_token'),
          scopes: ['openid', 'profile', 'email'],
          allowInsecureConnections: true),
    );

    _saveTokens(result);
  }

  Future<void> _saveTokens(TokenResponse result) async {
    await Future.wait([
      _secureStorage.write(key: 'access_token', value: result.accessToken),
      _secureStorage.write(key: 'id_token', value: result.idToken),
      _secureStorage.write(key: 'refresh_token', value: result.refreshToken),
    ]);
  }

  Future<bool> isUserLoggedIn() async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final idToken = await _secureStorage.read(key: 'access_token');
    final refreshToken = await _secureStorage.read(key: 'access_token');

    return accessToken != null && idToken != null && refreshToken != null;
  }
}