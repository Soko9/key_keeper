import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/controllers.dart';
import 'package:key_keeper/src/app/views/widgets/widgets.dart';

import '../../models/models.dart';
import '../screens/screens.dart';

class PasswordScreen extends StatelessWidget {
  final Password password;
  final bool fromSharable;
  final bool isSender;
  final String? userID;

  const PasswordScreen({
    super.key,
    required this.password,
    this.fromSharable = false,
    this.isSender = true,
    this.userID,
  });

  SettingsController get _settingsController => Get.find<SettingsController>();
  PasswordController get _passwordController => Get.find<PasswordController>();
  SharableController get _sharableController => Get.find<SharableController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      height: size.height * 0.75,
      child: Column(
        spacing: 24.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            padding: const EdgeInsets.all(24.0),
            child: Row(
              spacing: 12.0,
              children: [
                CircleAvatar(
                  backgroundColor: theme.scaffoldBackgroundColor,
                  radius: 32.0,
                  child: Icon(
                    password.icon.icon,
                    color: theme.textTheme.bodyLarge?.color,
                    size: 32.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0,
                    children: [
                      Text(
                        password.icon.name,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (password.getNeedUpdate(_settingsController.days))
                        Text(
                          '${password.getExpiresIn(_settingsController.days)} Days Left',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.error,
                            fontSize: 12.0,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: theme.scaffoldBackgroundColor,
                  ),
                  color: theme.colorScheme.primary,
                  iconSize: 12.0,
                  icon: const Icon(FontAwesomeIcons.x),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 24.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ModalSection(title: 'Username', value: password.username),
                  _ModalSection(title: 'Password', value: password.password),
                  _ModalSection(
                    title: 'Strength',
                    value: password.strength.label,
                    color: password.strength.color,
                  ),
                  _ModalSection(title: 'Created At', value: password.createdAt),
                  _ModalSection(
                    title: 'Last Time Updated',
                    value: password.updatedAt,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: fromSharable
                ? FittedBox(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: theme.colorScheme.primaryContainer,
                      ),
                      child: Text('${isSender ? '->' : '<-'} $userID'),
                    ),
                  )
                : Row(
                    spacing: 8.0,
                    children: [
                      IconButton(
                        onPressed: () {
                          _sharableController.clearError();
                          showDialog(
                            context: context,
                            builder: (_) => ShareDialog(
                              password: password,
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                        icon: const Icon(FontAwesomeIcons.share),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Get.to(
                              () => AddPasswordScreen(
                                password: password,
                              ),
                            );
                          },
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          icon: Text(
                            'Edit Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Get.back();
                          await _passwordController.deletePassword(
                            password: password,
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                        ),
                        icon: const Icon(FontAwesomeIcons.trash),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ModalSection extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;

  const _ModalSection({
    required this.title,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
              color: color ?? theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
