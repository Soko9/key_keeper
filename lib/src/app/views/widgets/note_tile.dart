import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/models/models.dart';

import '../painters/painters.dart';
import 'note_screen.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    final bool isLargeScreen = size.width >= 800.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(4.0),
            ),
            isScrollControlled: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            builder: (_) => NoteScreen(
              note: note,
            ),
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipPath(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              clipper: isLargeScreen ? null : NoteClipper(),
              child: Container(
                padding: isLargeScreen ? const EdgeInsets.all(8.0) : null,
                width: isLargeScreen ? 800.0 * 0.4 : size.width * 0.4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        note.title.capitalize!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0,
                        bottom: 4.0,
                        left: 4.0,
                        right: size.width * 0.1,
                      ),
                      child: Text(
                        note.note.length >= 25
                            ? '${note.note.substring(0, 26)}...'
                            : note.note,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: theme.iconTheme.color?.withValues(alpha: 0.7),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -4.0,
              right: -4.0,
              child: CustomPaint(
                painter: NoteFold(color: theme.scaffoldBackgroundColor),
                size: const Size.square(24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
