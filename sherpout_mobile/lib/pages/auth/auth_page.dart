import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sherpoutmobile/common/auth_service.dart';

import '../../common/user_provider.dart';

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
              onPressed: () => loginUser(context),
              child: Text(AppLocalizations.of(context)!.loginOrRegister),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    try {
      await _authService.login(context);
      await userProvider.fetch();

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd logowania: $e')),
      );
    }
  }
}
