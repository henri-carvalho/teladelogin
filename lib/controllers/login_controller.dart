// login_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/mock_users.dart';

class LoginController {
  static bool performLogin(
    BuildContext context, {
    required GlobalKey<NavigatorState> navigatorKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  }) {
    String username = usernameController.text;
    String password = passwordController.text;

    if (_isLoginValid(username, password)) {
      navigatorKey.currentState?.pushReplacementNamed('/home');
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content:
                const Text('Incorrect username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  static bool _isLoginValid(String username, String password) {
    for (var user in MOCK_USERS.values) {
      if (user.user_id == username && user.senha == password) {
        return true;
      }
    }
    return false;
  }
}
