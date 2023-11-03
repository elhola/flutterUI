//mobile_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:uimenu/web_menu.dart';


class MobileMenu extends StatelessWidget {
  final FlutterAppAuth appAuth = FlutterAppAuth();

  void openWebMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebMenu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мобільне меню')),
      body: Center(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Порівняти з веб-меню'),
              onTap: () {
                openWebMenu(context);
              },
            ),
            ListTile(
              title: Text('Вхід через OAuth0'),
              onTap: () async {
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
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
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
              title: Text('Про нас'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}

