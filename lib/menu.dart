import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class MenuScreen extends StatelessWidget {
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
        title: kIsWeb ? Text('Веб-меню') : Text('Мобільне меню'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          kIsWeb
              ? Text('Ласкаво просимо!', style: TextStyle(fontSize: 24))
              : Text('З поверненням @test_user!', style: TextStyle(fontSize: 24)),
          ListTile(
            title: Text('Вхід через OAuth0'),
            onTap: () {
              authenticateWithOAuth(context);
            },
          ),
        ],
      ),
      drawer: !kIsWeb
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('@test_nickname'),
              accountEmail: Text('yarmcfly@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('Про нас')
            ),
          ],
        ),
      )
          : null,
    );
  }
}
