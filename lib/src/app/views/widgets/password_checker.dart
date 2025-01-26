import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/utils.dart';

class PasswordChecker extends StatelessWidget {
  final double value;
  final String password;

  const PasswordChecker({
    super.key,
    required this.value,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final checker = value < 0.2
        ? 'Weak'
        : value < 0.5
            ? 'Fair'
            : value < 0.9
                ? 'Good'
                : 'Strong';

    final style = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: value < 0.2
          ? AppColors.weakColor
          : value < 0.5
              ? AppColors.fairColor
              : value < 0.9
                  ? AppColors.goodColor
                  : AppColors.strongColor,
    );

    final icon = value < 0.2
        ? FontAwesomeIcons.x
        : value < 0.5
            ? FontAwesomeIcons.unlockKeyhole
            : value < 0.9
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.shield;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          value: value,
          color: style.color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        4.gapV,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              PasswordHelper.validateReason(password),
              style: style.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(checker, style: style),
                4.gapH,
                Icon(
                  icon,
                  size: 12.0,
                  color: style.color,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
