import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/errors/errors.dart';
import '../../controllers/controllers.dart';
import '../widgets/widgets.dart';
import '../../../core/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onToggleScreen;

  const RegisterScreen({super.key, required this.onToggleScreen});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController get _authController => Get.find<AuthController>();

  final PageController _pageController = PageController(
    viewportFraction: 1.0,
    initialPage: 0,
  );

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _answer = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordHidden = true;
  AuthFactorQuestion _question = AuthFactorQuestion.nickname;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _answer.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void reset() {
    _email.clear();
    _password.clear();
    _confirmPassword.clear();
    _answer.clear();
    _isPasswordHidden = true;
    _question = AuthFactorQuestion.nickname;
    setState(() {});
  }

  Future<void> _register() async {
    _authController.clearError();
    if (_formKey.currentState!.validate()) {
      if (PasswordHelper.validateStrength(_password.text.trim()) < 0.5) {
        _authController.error = 'Master Password Must Be Stronger';
      } else if (_confirmPassword.text.trim() != _password.text.trim()) {
        _authController.error = 'Passwords Must Be Identical';
      } else {
        await _authController.register(
          email: _email.text.trim(),
          password: _password.text.trim(),
          question: _question.question,
          answer: _answer.text.trim(),
        );
        reset();
      }
    }
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
                                  '.REGISTER.',
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
                                PasswordInput(controller: _password),
                                TextFormField(
                                  controller: _confirmPassword,
                                  obscureText: _isPasswordHidden,
                                  decoration: const InputDecoration(
                                    hintText: 'Confirm Master Password',
                                  ),
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
                                  onPressed: _register,
                                  child: const Text('register'),
                                ),
                                OutlinedButton(
                                  onPressed: widget.onToggleScreen,
                                  child: const Text('login'),
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
