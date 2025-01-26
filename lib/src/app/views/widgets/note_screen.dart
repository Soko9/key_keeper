import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/controllers.dart';

import '../../models/models.dart';
import '../screens/screens.dart';

class NoteScreen extends StatelessWidget {
  final Note note;

  const NoteScreen({
    super.key,
    required this.note,
  });

  NoteController get _noteController => Get.find<NoteController>();

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
                  radius: 24.0,
                  child: Icon(
                    FontAwesomeIcons.solidNoteSticky,
                    color: theme.textTheme.bodyLarge?.color,
                    size: 16.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
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
              padding: const EdgeInsets.all(12.0),
              child: SelectableText(
                note.note,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Get.to(
                        () => AddNoteScreen(
                          note: note,
                        ),
                      );
                    },
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    icon: Text(
                      'Edit Note',
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
                    await _noteController.deleteNote(
                      note: note,
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
