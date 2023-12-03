import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/mock_users.dart';
import 'package:myapp/models/user.dart';

class CreateUserPage extends StatelessWidget {
  // Controladores de texto para os campos do formulário
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController avatarUrlController = TextEditingController();

  // Contador para gerar IDs automaticamente
  int _idCounter = MOCK_USERS.length + 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2014/09/11/22/00/dock-441989_1280.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0),
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
                    "New user",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Full Name",
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Username",
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    controller: usernameController,
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Password",
                    obscureText: true,
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    padding: const EdgeInsets.all(15),
                    placeholder: "Avatar URL",
                    placeholderStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    controller: avatarUrlController,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(17),
                      color: const Color.fromRGBO(29, 51, 99, 1),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        _createAccount(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 7),
                  CupertinoButton(
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createAccount(BuildContext context) {
    String fullName = fullNameController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    String avatarUrl = avatarUrlController.text;

    if (fullName.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        avatarUrl.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Campos obrigatórios'),
            content:
                const Text('Preencha todos os campos para criar uma conta.'),
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
      return;
    }

    User newUser = User(
      id: _idCounter.toString(),
      name: fullName,
      user_id: username,
      senha: password,
      avatarUrl: avatarUrl,
    );

    MOCK_USERS[_idCounter.toString()] = newUser;
    _idCounter++;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Conta criada'),
          content: const Text('Sua conta foi criada com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/login");
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
