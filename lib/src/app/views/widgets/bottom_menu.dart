import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomMenu extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final bool isAddClicked;
  final void Function(bool value) updateAddClicked;
  final void Function(bool value) updatePasswordChoosen;

  const BottomMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isAddClicked,
    required this.updateAddClicked,
    required this.updatePasswordChoosen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        _buildItem(icon: FontAwesomeIcons.lock, label: 'Vault'),
        _buildItem(icon: FontAwesomeIcons.solidNoteSticky, label: 'Notes'),
        BottomNavigationBarItem(
          label: '',
          icon: GestureDetector(
            onTap: () {
              if (isAddClicked) {
                updateAddClicked(false);
                onTap(0);
              } else {
                Get.bottomSheet(
                  IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 48.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2.0,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                updateAddClicked(true);
                                updatePasswordChoosen(true);
                                Get.back();
                                onTap(2);
                              },
                              child: CircleAvatar(
                                radius: 32.0,
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  color: theme.textTheme.bodyLarge?.color,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                updateAddClicked(true);
                                updatePasswordChoosen(false);
                                Get.back();
                                onTap(2);
                              },
                              child: CircleAvatar(
                                radius: 32.0,
                                child: Icon(
                                  FontAwesomeIcons.solidNoteSticky,
                                  color: theme.textTheme.bodyLarge?.color,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: isAddClicked
                  ? theme.scaffoldBackgroundColor
                  : theme.colorScheme.primary,
              child: Icon(
                isAddClicked ? FontAwesomeIcons.x : FontAwesomeIcons.plus,
                color: isAddClicked
                    ? theme.colorScheme.primary
                    : theme.scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        _buildItem(icon: FontAwesomeIcons.dice, label: 'Generate'),
        _buildItem(icon: FontAwesomeIcons.gear, label: 'Settings'),
      ],
    );
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        size: 18.0,
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Icon(
          icon,
          size: 20.0,
        ),
      ),
      label: label,
    );
  }
}
