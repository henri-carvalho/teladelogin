import 'package:flutter/material.dart';
import 'package:myapp/views/create_user.dart';
import 'package:myapp/views/list_users.dart';
import 'package:myapp/views/login_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginPage(navigatorKey: navigatorKey),
        "/home": (context) => UserList(),
        "/create": (context) => CreateUserPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(navigatorKey: navigatorKey),
    );
  }
}
