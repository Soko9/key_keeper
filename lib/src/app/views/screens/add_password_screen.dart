import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/home_screen.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../widgets/widgets.dart';
import '../../../core/errors/errors.dart';
import '../../../core/utils/utils.dart';

class AddPasswordScreen extends StatefulWidget {
  final Password? password;

  const AddPasswordScreen({super.key, this.password});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  AuthController get _authController => Get.find<AuthController>();
  PasswordController get _passwordController => Get.find<PasswordController>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  PlatformIcon _icon = PlatformIcon.other;

  bool _isPasswordHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.password != null) _populateForm();
    });
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _populateForm() {
    _username.text = widget.password!.username;
    _password.text = widget.password!.password;
    _icon = widget.password!.icon;
    setState(() {});
  }

  void _reset() {
    _username.clear();
    _password.clear();
    _confirmPassword.clear();
    _icon = PlatformIcon.other;
    _isPasswordHidden = true;
    setState(() {});
  }

  Future<void> _upsertPassword() async {
    _passwordController.clearError();
    if (_formKey.currentState!.validate()) {
      if (_confirmPassword.text.trim() != _password.text.trim()) {
        _passwordController.error = 'Passwords Must Be Identical';
      } else {
        if (widget.password != null) {
          final pass = widget.password!.copyWith(
            password: _password.text.trim(),
            username: _username.text.trim(),
            icon: _icon,
            lastTimeUpdated: DateTime.now(),
          );
          await _passwordController.updatePassword(
            password: pass,
            userID: _authController.currentID,
          );
          Get.offAllNamed(HomeScreen.routeName);
        } else {
          await _passwordController.addPassword(
            password: _password.text.trim(),
            username: _username.text.trim(),
            icon: _icon,
            userID: _authController.currentID,
          );
        }
        _reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final bool isUpdating = widget.password != null;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.15,
                    child: CustomPaint(
                      painter: _HeaderPainter(color: theme.colorScheme.primary),
                    ),
                  ),
                  Expanded(
                    child: _passwordController.isLoading
                        ? const Loader()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                spacing: 16.0,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (_passwordController.error.isNotEmpty)
                                    ErrorMessage(
                                      message: _passwordController.error,
                                    ),
                                  Text(
                                    '.PASSWORD.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _username,
                                    decoration: const InputDecoration(
                                      hintText: 'Platform Username',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Platform Username Is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                  PasswordInput(controller: _password),
                                  TextFormField(
                                    controller: _confirmPassword,
                                    obscureText: _isPasswordHidden,
                                    decoration: const InputDecoration(
                                      hintText: 'Confirm Password',
                                    ),
                                  ),
                                  PlatformDropdown(
                                    selectedPlatform: _icon,
                                    onSelect: (platform) {
                                      setState(() {
                                        _icon = platform;
                                      });
                                    },
                                  ),
                                  8.gapV,
                                  ElevatedButton(
                                    onPressed: _upsertPassword,
                                    child: Text(
                                        '${isUpdating ? 'update' : 'add'} password'),
                                  ),
                                  100.gapV,
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  final Color color;
  const _HeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(size.width * 0.5, size.height * 1.25, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
