import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/controllers.dart';
import 'package:key_keeper/src/app/models/models.dart';

import 'password_screen.dart';

class SharableTile extends StatelessWidget {
  final Sharable sharable;

  const SharableTile({super.key, required this.sharable});

  AuthController get _authController => Get.find<AuthController>();
  SharableController get _sharableController => Get.find<SharableController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isSender = sharable.isSender(_authController.currentID);

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
            password: sharable.password,
            fromSharable: true,
            isSender: isSender,
            userID: isSender ? sharable.recieverID : sharable.senderID,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 8.0,
          bottom: 8.0,
          right: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(4.0),
            bottomLeft: Radius.circular(100.0),
            bottomRight: Radius.circular(4.0),
          ),
          color: theme.colorScheme.primaryContainer,
        ),
        child: Row(
          spacing: 12.0,
          children: [
            CircleAvatar(
              backgroundColor: isSender
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.error,
              child: Icon(
                isSender
                    ? FontAwesomeIcons.arrowUp
                    : FontAwesomeIcons.arrowDown,
                size: 16.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(
                  sharable.password.icon.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(sharable.password.username),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                await _sharableController.deleteSharable(sharable: sharable);
              },
              child: Icon(
                FontAwesomeIcons.trash,
                size: 18.0,
                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
