import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/screens.dart';
import 'package:key_keeper/src/core/helpers/helpers.dart';
import '../../controllers/controllers.dart';
import '../widgets/widgets.dart';
import '../../../core/errors/errors.dart';
import '../../../core/utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController get _settingsController => Get.find<SettingsController>();
  AuthController get _authController => Get.find<AuthController>();
  PasswordController get _passwordController => Get.find<PasswordController>();
  NoteController get _noteController => Get.find<NoteController>();
  SharableController get _sharableController => Get.find<SharableController>();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _answer = TextEditingController();
  AuthFactorQuestion _question = AuthFactorQuestion.nickname;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _qaFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _password.dispose();
    _answer.dispose();
    super.dispose();
  }

  void _reset() {
    _password.clear();
    setState(() {});
  }

  void _resetQA() {
    _answer.clear();
    _question = AuthFactorQuestion.nickname;
    setState(() {});
  }

  Future<void> _updatePassword() async {
    _authController.clearError();
    if (_formKey.currentState!.validate()) {
      if (PasswordHelper.validateStrength(_password.text.trim()) < 0.5) {
        _authController.error = 'Master Password Must Be Stronger';
      } else {
        await _authController.updateMasterPassword(
          newMasterPassword: _password.text.trim(),
        );
        _reset();
      }
    }
  }

  Future<void> _updateSecurityQA() async {
    _authController.clearError();
    if (_qaFormKey.currentState!.validate()) {
      await _authController.updateSecurityQA(
        newQuestion: _question.question,
        newAnswer: _answer.text.trim(),
      );
      _resetQA();
    }
  }

  void _openDurationModal() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12.0,
          children: [
            const Text('Password Expires Duration'),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12.0,
              children: DeadlineDuration.values
                  .map(
                    (v) => InkWell(
                      onTap: () {
                        _settingsController.setDays(value: v.duration);
                        Get.back();
                      },
                      child: Text(
                        '${v.duration} Days',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(),
    );
  }

  void _copyID() {
    Clipboard.setData(ClipboardData(text: _authController.currentID));
    ToastHelper.snackBar(
      context: context,
      title: 'DONE',
      content: 'ID Copied',
    );
  }

  void _openTermsModal() {
    Get.bottomSheet(
      const TermsScreen(),
      isScrollControlled: true,
    );
  }

  Future<void> _logout() async {
    _passwordController.passwords.clear();
    _noteController.notes.clear();
    _sharableController.sharables.clear();
    await _authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Obx(
                () => _authController.isLoading
                    ? const Loader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            spacing: 12.0,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: _copyID,
                                icon: Row(
                                  spacing: 8.0,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(FontAwesomeIcons.copy),
                                    Text(
                                      'ID',
                                      style: TextStyle(
                                        color: theme.scaffoldBackgroundColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: _openTermsModal,
                                icon: const Icon(FontAwesomeIcons.info),
                              ),
                              IconButton(
                                onPressed: _logout,
                                style: IconButton.styleFrom(
                                  backgroundColor: theme.colorScheme.error,
                                ),
                                icon: const Icon(FontAwesomeIcons.doorOpen),
                              ),
                            ],
                          ),
                          20.gapV,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _settingsController.setTheme(
                                      value: !_settingsController.isDark);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  padding: const EdgeInsets.all(8.0),
                                  width: size.width * 0.4,
                                  constraints: BoxConstraints.loose(
                                    Size(size.width * 0.4, size.height * 0.2),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36.0),
                                    color: theme.colorScheme.primary,
                                  ),
                                  alignment: _settingsController.isDark
                                      ? Alignment.bottomLeft
                                      : Alignment.topRight,
                                  child: Icon(
                                    _settingsController.isDark
                                        ? FontAwesomeIcons.solidMoon
                                        : FontAwesomeIcons.solidSun,
                                    size: 64.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _openDurationModal,
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  constraints: BoxConstraints.loose(
                                    Size(size.width * 0.4, size.height * 0.2),
                                  ),
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36.0),
                                    color: theme.colorScheme.primaryContainer,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _settingsController.days.toString(),
                                        style: const TextStyle(
                                          fontSize: 48.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'days',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          32.gapV,
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 24.0,
                              children: [
                                if (_authController.error.isNotEmpty)
                                  ErrorMessage(message: _authController.error),
                                const Text('Update Master Password'),
                                Form(
                                  key: _formKey,
                                  child: PasswordInput(controller: _password),
                                ),
                                OutlinedButton(
                                  onPressed: _updatePassword,
                                  child: const Text('update password'),
                                ),
                              ],
                            ),
                          ),
                          32.gapV,
                          Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 24.0,
                              children: [
                                const Text('Update Security QA'),
                                Form(
                                  key: _qaFormKey,
                                  child: SecurityInput(
                                    label: '',
                                    question: _question,
                                    onChange: (value) {
                                      setState(() {
                                        _question = value;
                                      });
                                    },
                                    controller: _answer,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: _updateSecurityQA,
                                  child: const Text('update security'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
