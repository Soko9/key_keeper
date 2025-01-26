import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:key_keeper/src/core/utils/app_enums.dart';

class PlatformDropdown extends StatelessWidget {
  final PlatformIcon selectedPlatform;
  final void Function(PlatformIcon platform) onSelect;

  const PlatformDropdown({
    super.key,
    required this.selectedPlatform,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        const Text('Platform'),
        Row(
          spacing: 12.0,
          children: [
            Icon(
              selectedPlatform.icon,
              size: 16.0,
              color: theme.colorScheme.primary,
            ),
            Expanded(
              child: DropdownMenu<PlatformIcon>(
                initialSelection: selectedPlatform,
                enableSearch: true,
                menuHeight: 200.0,
                requestFocusOnTap: true,
                trailingIcon: const Icon(
                  FontAwesomeIcons.arrowDown,
                ),
                onSelected: (value) {
                  onSelect(value ?? PlatformIcon.other);
                },
                expandedInsets: EdgeInsets.zero,
                dropdownMenuEntries: PlatformIcon.sortedValues
                    .map(
                      (e) => DropdownMenuEntry<PlatformIcon>(
                        label: e.name,
                        leadingIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: Icon(
                            e.icon,
                            size: 18.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        value: e,
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          textStyle: WidgetStatePropertyAll(
                            theme.dropdownMenuTheme.textStyle!,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
