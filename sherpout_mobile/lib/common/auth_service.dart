import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/common/user_provider.dart';

final getIt = GetIt.instance;

class AuthService {
  final String clientId = dotenv.env['KEYCLOAK_CLIENT_ID']!;
  final String redirectUrl = dotenv.env['KEYCLOAK_REDIRECT_URL']!;
  final String issuer = dotenv.env['KEYCLOAK_URL']!;

  final FlutterAppAuth _appAuth;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._appAuth, this._secureStorage);

  Future<void> login(BuildContext context) async {
    try {
      final AuthorizationTokenResponse result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientId, redirectUrl,
            issuer: issuer,
            scopes: ['openid', 'profile', 'email'],
            allowInsecureConnections: true),
      );

      if (!context.mounted) return;
      await _saveTokensAndFetchUser(context, result);

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      print("Błąd logowania: $e");
    }
  }

  Future<void> refreshToken(BuildContext context) async {
    try {
      final TokenResponse result = await _appAuth.token(
        TokenRequest(clientId, redirectUrl,
            discoveryUrl: '$issuer/protocol/openid-connect/token',
            refreshToken: await _secureStorage.read(key: 'refresh_token'),
            scopes: ['openid', 'profile', 'email'],
            allowInsecureConnections: true),
      );

      if (!context.mounted) return;
      _saveTokensAndFetchUser(context, result);
    } catch (e) {
      print("Błąd odświeżania tokenu: $e");
    }
  }

  Future<void> _saveTokensAndFetchUser(BuildContext context, TokenResponse result) async {
    await Future.wait([
      _secureStorage.write(key: 'access_token', value: result.accessToken),
      _secureStorage.write(key: 'id_token', value: result.idToken),
      _secureStorage.write(key: 'refresh_token', value: result.refreshToken),
    ]);

    if (!context.mounted) return;
    await Provider.of<UserProvider>(context, listen: false).fetch();
  }

  Future<bool> isUserLoggedIn() async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    return accessToken != null;  }
}