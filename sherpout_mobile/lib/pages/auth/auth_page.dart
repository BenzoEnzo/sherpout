import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

const String clientId = "mobile-app";
const String redirectUrl = "com.sherpout.sherpoutmobile:/oauth2redirect";
const String issuer = "http://192.168.100.45:8082/realms/Sherpout/";

Future<void> login(BuildContext context) async {
  try {
    final AuthorizationTokenResponse result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(clientId, redirectUrl,
          issuer: issuer,
          scopes: ['openid', 'profile', 'email'],
          allowInsecureConnections: true),
    );

    await secureStorage.write(key: 'access_token', value: result.accessToken);
    await secureStorage.write(key: 'id_token', value: result.idToken);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  } catch (e) {
    print("Błąd logowania: $e");
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => login(context),
              child: Text(AppLocalizations.of(context)!.loginOrRegister),
            ),
          ],
        ),
      ),
    );
  }
}
