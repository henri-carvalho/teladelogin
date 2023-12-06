import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controllers/create_user_controller.dart';

class CreateUserPage extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController avatarUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
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
              width: isMobile
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.all(20),
              padding: const EdgeInsets.all(27),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "New user",
                      style: TextStyle(
                        color: const Color.fromRGBO(29, 51, 99, 1),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextField(
                      padding: const EdgeInsets.all(15),
                      placeholder: "Full Name",
                      placeholderStyle:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      style:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.black45,
                          width: 0.5,
                        ),
                      ),
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            padding: const EdgeInsets.all(15),
                            placeholder: "Username",
                            placeholderStyle: const TextStyle(
                                color: Colors.black45, fontSize: 14),
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 14),
                            decoration: BoxDecoration(
                              color: Colors.grey[200], // Light grey color
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Colors.grey[300] ??
                                    Colors
                                        .grey, // Slightly darker grey color, defaulting to Colors.grey

                                width: 0.5,
                              ),
                            ),
                            controller: usernameController,
                            enabled: false, // Make username non-editable
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(29, 51, 99, 1),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              String generatedUsername =
                                  UserCreationLogic.generateUsername(
                                      fullNameController.text);
                              usernameController.text = generatedUsername;
                            },
                            child: const Text(
                              "Generate Username",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextField(
                      padding: const EdgeInsets.all(15),
                      placeholder: "Password",
                      obscureText: true,
                      placeholderStyle:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      style:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.black45,
                          width: 0.5,
                        ),
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 10),
                    CupertinoTextField(
                      padding: const EdgeInsets.all(15),
                      placeholder: "Insert a link to your profile picture",
                      placeholderStyle:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      style:
                          const TextStyle(color: Colors.black45, fontSize: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.black45,
                          width: 0.5,
                        ),
                      ),
                      controller: avatarUrlController,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(29, 51, 99, 1),
                          padding: const EdgeInsets.all(17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          UserCreationLogic.createAccount(
                            context,
                            fullNameController: fullNameController,
                            usernameController: usernameController,
                            passwordController: passwordController,
                            avatarUrlController: avatarUrlController,
                          );
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    CupertinoButton(
                      child: const Text(
                        "Back to Login",
                        style: TextStyle(
                          color: const Color.fromRGBO(29, 51, 99, 1),
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
          ),
        ],
      ),
    );
  }
}
