import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';

class Specs extends StatelessWidget {
  final PasswordStrength strength;
  final int number;

  const Specs({
    super.key,
    required this.strength,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Center(
          child: Row(
            spacing: 18.0,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: strength.color.withValues(alpha: 0.2),
                ),
                child: Icon(
                  strength.icon,
                  color: strength.color,
                  size: 12.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    strength.label,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: strength.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
