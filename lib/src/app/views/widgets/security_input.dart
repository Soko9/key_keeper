import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/app_enums.dart';

class SecurityInput extends StatelessWidget {
  final AuthFactorQuestion question;
  final void Function(AuthFactorQuestion value) onChange;
  final TextEditingController controller;
  final String label;

  const SecurityInput({
    super.key,
    required this.question,
    required this.onChange,
    required this.controller,
    this.label = 'Security Question',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 12.0,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            if (label.isNotEmpty) Text(label),
            DropdownMenu<AuthFactorQuestion>(
              initialSelection: question,
              requestFocusOnTap: true,
              trailingIcon: const Icon(
                FontAwesomeIcons.arrowDown,
              ),
              menuHeight: 200.0,
              onSelected: (value) {
                onChange(value ?? AuthFactorQuestion.nickname);
              },
              expandedInsets: EdgeInsets.zero,
              dropdownMenuEntries: AuthFactorQuestion.values
                  .map(
                    (e) => DropdownMenuEntry<AuthFactorQuestion>(
                      label: e.question,
                      value: e,
                      style: theme.elevatedButtonTheme.style?.copyWith(
                        textStyle: WidgetStatePropertyAll(
                            theme.dropdownMenuTheme.textStyle!),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Answer',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Answer Is Required';
            }
            return null;
          },
        )
      ],
    );
  }
}
