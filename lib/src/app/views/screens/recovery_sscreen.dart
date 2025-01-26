import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/auth_controller.dart';
import 'package:key_keeper/src/app/views/widgets/loader.dart';
import 'package:key_keeper/src/core/utils/utils.dart';

import '../widgets/password_input.dart';
import '../widgets/security_input.dart';

class RecoverySscreen extends StatefulWidget {
  const RecoverySscreen({super.key});

  static const String routeName = '/recovery';

  @override
  State<RecoverySscreen> createState() => _RecoverySscreenState();
}

class _RecoverySscreenState extends State<RecoverySscreen> {
  AuthController get _authController => Get.find<AuthController>();

  final TextEditingController _recoveryEmail = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _answer = TextEditingController();
  final TextEditingController _token = TextEditingController();

  AuthFactorQuestion _question = AuthFactorQuestion.nickname;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _recoveryEmail.dispose();
    _email.dispose();
    _password.dispose();
    _answer.dispose();
    _token.dispose();
    super.dispose();
  }

  void _reset() {
    _recoveryEmail.clear();
    _email.clear();
    _password.clear();
    _answer.clear();
    _token.clear();
    _question = AuthFactorQuestion.nickname;
    setState(() {});
  }

  Future<void> _sendToken() async {
    if (_formKey.currentState!.validate()) {
      await _authController.sendToken(email: _recoveryEmail.text.trim());
      _recoveryEmail.clear();
    }
  }

  Future<void> _verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      await _authController.verifyOTP(
        email: _email.text.trim(),
        newPassword: _password.text.trim(),
        newQuestion: _question.question,
        newAnswer: _answer.text.trim(),
        token: _token.text.trim(),
      );
      _reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Center(
            child: Obx(
              () => _authController.isLoading
                  ? const Loader()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: !_authController.emailSent
                            ? Column(
                                children: [
                                  TextFormField(
                                    controller: _recoveryEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: 'Recovery Email',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email Is Required';
                                      }
                                      if (!GetUtils.isEmail(value)) {
                                        return 'Invalid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  16.gapV,
                                  ElevatedButton(
                                    onPressed: _sendToken,
                                    child: const Text('send token'),
                                  ),
                                ],
                              )
                            : Column(
                                spacing: 8.0,
                                children: [
                                  Text(
                                    '.RECOVERY.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email Is Required';
                                      }
                                      if (!GetUtils.isEmail(value)) {
                                        return 'Invalid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  PasswordInput(
                                    controller: _password,
                                  ),
                                  8.gapV,
                                  SecurityInput(
                                    question: _question,
                                    onChange: (value) {
                                      setState(() {
                                        _question = value;
                                      });
                                    },
                                    controller: _answer,
                                  ),
                                  8.gapV,
                                  TextFormField(
                                    controller: _token,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Token',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Token Is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                  8.gapV,
                                  ElevatedButton(
                                    onPressed: _verifyOTP,
                                    child: const Text('verify'),
                                  ),
                                ],
                              ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
