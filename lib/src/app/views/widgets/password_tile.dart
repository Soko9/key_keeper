import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/controllers.dart';

import '../../models/models.dart';
import 'password_screen.dart';

class PasswordTile extends StatelessWidget {
  final Password password;

  const PasswordTile({
    super.key,
    required this.password,
  });

  SettingsController get _settingsController => Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(4.0),
          ),
          isScrollControlled: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          builder: (_) => PasswordScreen(
            password: password,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          tileColor: theme.colorScheme.primaryContainer,
          leading: Badge(
            backgroundColor: password.getNeedUpdate(_settingsController.days)
                ? theme.colorScheme.error
                : Colors.transparent,
            child: CircleAvatar(
              backgroundColor: theme.scaffoldBackgroundColor,
              child: Icon(
                password.icon.icon,
                color: theme.textTheme.bodyLarge?.color,
                size: 16.0,
              ),
            ),
          ),
          title: Text(
            password.icon.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            password.username,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 10.0,
              color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: password.strength.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              password.strength.label,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: password.strength.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
