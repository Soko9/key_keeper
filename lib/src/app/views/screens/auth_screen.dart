import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String routeName = '/';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _inLoginScreen = true;

  void _toggleScreen() {
    setState(() {
      _inLoginScreen = !_inLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _inLoginScreen
        ? LoginScreen(
            onToggleScreen: _toggleScreen,
          )
        : RegisterScreen(
            onToggleScreen: _toggleScreen,
          );
  }
}
