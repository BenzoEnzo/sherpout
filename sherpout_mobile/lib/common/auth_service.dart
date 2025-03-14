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

      await _secureStorage.write(key: 'access_token', value: result.accessToken);
      await _secureStorage.write(key: 'id_token', value: result.idToken);

      if (context.mounted) {
        await Provider.of<UserProvider>(context, listen: false).fetch();
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      print("Błąd logowania: $e");
    }
  }

  Future<bool> isUserLoggedIn() {
    return _secureStorage.read(key: 'access_key').then((key) => key != null);
  }
}