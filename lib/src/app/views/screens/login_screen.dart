import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/screens.dart';
import '../widgets/widgets.dart';
import '../../../core/errors/errors.dart';
import '../../controllers/controllers.dart';
import '../../../core/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onToggleScreen;

  const LoginScreen({super.key, required this.onToggleScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController get _authController => Get.find<AuthController>();

  final PageController _pageController = PageController(
    viewportFraction: 1.0,
    initialPage: 0,
  );

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _answer = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthFactorQuestion _question = AuthFactorQuestion.nickname;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _answer.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void reset() {
    _email.clear();
    _password.clear();
    _answer.clear();
    _question = AuthFactorQuestion.nickname;
    setState(() {});
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await _authController.login(
        email: _email.text.trim(),
        password: _password.text.trim(),
        question: _question.question,
        answer: _answer.text.trim(),
      );
      reset();
    }
  }

  void _sendToken() {
    Get.toNamed(RecoverySscreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Obx(
              () => _authController.isLoading
                  ? const Loader()
                  : SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (_authController.error.isNotEmpty)
                              ErrorMessage(message: _authController.error),
                            Column(
                              spacing: 16.0,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '.LOGIN.',
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
                                  withChecker: false,
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
                                ElevatedButton(
                                  onPressed: _login,
                                  child: const Text('login'),
                                ),
                                OutlinedButton(
                                  onPressed: widget.onToggleScreen,
                                  child: const Text('register'),
                                ),
                                32.gapV,
                                TextButton(
                                  onPressed: _sendToken,
                                  child: const Text(
                                    'Forget Password OR Security QA',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
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
