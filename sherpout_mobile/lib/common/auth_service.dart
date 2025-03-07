import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/common/user_provider.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  final String clientId = dotenv.env['KEYCLOAK_CLIENT_ID']!;
  final String redirectUrl = dotenv.env['KEYCLOAK_REDIRECT_URL']!;
  final String issuer = dotenv.env['KEYCLOAK_URL']!;

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
        Navigator.pushReplacementNamed(context, '/dashboard');
        Provider.of<UserProvider>(context, listen: false).fetch();
      }
    } catch (e) {
      print("Błąd logowania: $e");
    }
  }
}