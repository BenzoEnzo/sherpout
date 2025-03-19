import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/auth_service.dart';

final getIt = GetIt.instance;

class AuthPage extends StatelessWidget {
  final AuthService _authService = GetIt.instance<AuthService>();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _authService.login(context),
              child: Text(AppLocalizations.of(context)!.loginOrRegister),
            ),
          ],
        ),
      ),
    );
  }
}
