// user_creation_logic.dart

import 'package:flutter/material.dart';
import 'package:myapp/data/mock_users.dart';
import 'package:myapp/models/user.dart';

class UserCreationLogic {
  static int _idCounter = MOCK_USERS.length + 1;

  static void createAccount(
    BuildContext context, {
    required TextEditingController fullNameController,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required TextEditingController avatarUrlController,
  }) {
    String fullName = fullNameController.text;
    String username =
        generateUsername(fullName); // Automatically generate username
    String password = passwordController.text;
    String avatarUrl = avatarUrlController.text;

    if (fullName.isEmpty || password.isEmpty || avatarUrl.isEmpty) {
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

    if (!isPasswordValid(password)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Senha inválida'),
            content: const Text(
                'A senha deve ter no mínimo 6 caracteres, com pelo menos uma letra maiúscula, uma letra minúscula e um caractere especial.'),
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

  static bool isPasswordValid(String password) {
    // Password validation logic
    // At least 6 characters, at least one uppercase letter,
    // one lowercase letter, and one special character.
    final RegExp passwordRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    return passwordRegex.hasMatch(password);
  }

  static String generateUsername(String fullName) {
    // Automatically generate username using first name and last name (lowercase)
    List<String> names = fullName.split(' ');
    if (names.length >= 2) {
      String firstName = names[0].toLowerCase();
      String lastName = names.last.toLowerCase();
      return '$firstName.$lastName';
    } else {
      // Handle cases where full name does not have a first and last name
      return fullName.toLowerCase();
    }
  }
}
