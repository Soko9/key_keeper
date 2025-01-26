import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/widgets/specs.dart';
import 'package:key_keeper/src/core/errors/errors.dart';
import '../../../core/utils/utils.dart';
import '../../controllers/controllers.dart';
import '../painters/painters.dart';
import '../widgets/widgets.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  AuthController get _authController => Get.find<AuthController>();
  PasswordController get _passwordController => Get.find<PasswordController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPasswords();
    });
  }

  Future<void> _getPasswords({bool isRefresh = false}) async {
    await _passwordController.getAllPasswords(
      id: _authController.currentID,
      isRefresh: isRefresh,
    );
  }

  void _openSharables() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(),
      isScrollControlled: true,
      builder: (_) => const SharablesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: Obx(
        () => _passwordController.isLoading
            ? const Loader()
            : Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.35,
                        child: CustomPaint(
                          painter: HeaderPainter(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.8),
                          ),
                          //> METER
                          child: Meter(score: _passwordController.score),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: size.height * 0.325,
                    left: 18.0,
                    right: 18.0,
                    bottom: 0,
                    child: RefreshIndicator(
                      onRefresh: () async => _getPasswords(isRefresh: true),
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 24.0,
                          children: [
                            //> SPECS
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 12.0,
                              children: [
                                Row(
                                  spacing: 12.0,
                                  children: [
                                    Specs(
                                      strength: PasswordStrength.strong,
                                      number: _passwordController.strong,
                                    ),
                                    Specs(
                                      strength: PasswordStrength.good,
                                      number: _passwordController.good,
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 12.0,
                                  children: [
                                    Specs(
                                      strength: PasswordStrength.fair,
                                      number: _passwordController.fair,
                                    ),
                                    Specs(
                                      strength: PasswordStrength.weak,
                                      number: _passwordController.weak,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //> PASSWORDS
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4.0,
                              children: [
                                if (_passwordController.error.isNotEmpty)
                                  ErrorMessage(
                                      message: _passwordController.error),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8.0,
                                  children: [
                                    Text(
                                      '${_passwordController.passwords.isEmpty ? 'No ' : ''}'
                                      'Passwords',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (!Platform.isAndroid && !Platform.isIOS)
                                      InkWell(
                                        onTap: () async =>
                                            _getPasswords(isRefresh: true),
                                        child: Icon(
                                          FontAwesomeIcons.arrowsRotate,
                                          size: 10.0,
                                          color:
                                              theme.textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      _passwordController.passwords.length,
                                  itemBuilder: (_, index) {
                                    final pass =
                                        _passwordController.passwords[index];
                                    return PasswordTile(password: pass);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12.0,
                    right: 12.0,
                    child: InkWell(
                      onTap: _openSharables,
                      child: const Icon(FontAwesomeIcons.scroll),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
