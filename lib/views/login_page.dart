import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/mock_users.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.navigatorKey}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2021/09/30/17/54/port-6670684_1280.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.white.withOpacity(0),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.all(27),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Kuehne-Nagel Code challenge",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "user",
                    controller: usernameController,
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "password",
                    obscureText: true,
                    controller: passwordController,
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(17),
                      color: const Color.fromRGBO(29, 51, 99, 1),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        _performLogin(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 7),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      child: const Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/create");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogin(BuildContext context) {
    String username = usernameController.text;
    String password = passwordController.text;

    if (_isLoginValid(username, password)) {
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro de Login'),
            content: const Text('Login ou senha incorretos. Tente novamente.'),
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
    }
  }

  bool _isLoginValid(String username, String password) {
    for (var user in MOCK_USERS.values) {
      if (user.user_id == username && user.senha == password) {
        return true;
      }
    }
    return false;
  }
}
