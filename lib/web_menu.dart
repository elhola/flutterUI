//web_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class WebMenu extends StatelessWidget {
  final FlutterAppAuth appAuth = FlutterAppAuth();

  Future<void> authenticateWithOAuth(BuildContext context) async {
    final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        '246785932392-cf3in5bfvgj3bc0ok8sufrid3fbr0b5h.apps.googleusercontent.com',
        'https://github.com/elhola',
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://accounts.google.com/o/oauth2/auth',
          tokenEndpoint: 'https://accounts.google.com/o/oauth2/token',
        ),
        scopes: ['email', 'profile'],
      ),
    );

    if (result != null) {
      if (result.tokenType == 'Bearer') {
        print('Аутентификація успішна: ${result.accessToken}');
      } else {
        print('Аутентификація не вдалась');
      }
    } else {
      print('Аутентификація не завершена');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Text('Веб-меню', style: TextStyle(fontSize: 24)),
          ListTile(
            title: Text('Вхід через OAuth0'),
            onTap: () {
              authenticateWithOAuth(context);
            },
          ),
        ],
      ),
    );
  }
}
