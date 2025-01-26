import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/widgets/widgets.dart';
import 'package:key_keeper/src/core/utils/app_extensions.dart';
import '../../controllers/controllers.dart';
import '../../../core/errors/errors.dart';
import '../painters/painters.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  AuthController get _authController => Get.find<AuthController>();
  NoteController get _noteController => Get.find<NoteController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNotes();
    });
  }

  Future<void> _getNotes({bool isRefresh = false}) async {
    await _noteController.getAllNotes(
      id: _authController.currentID,
      isRefresh: isRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Obx(
        () => _noteController.isLoading
            ? const Loader()
            : _noteController.error.isNotEmpty
                ? ErrorMessage(message: _noteController.error)
                : Column(
                    children: [
                      SizedBox.fromSize(
                        size: Size.fromHeight(size.height * 0.35),
                        child: CustomPaint(
                          painter: HeaderPainter(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.8),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: (!Platform.isAndroid && !Platform.isIOS)
                                  ? () async => _getNotes(isRefresh: true)
                                  : null,
                              child: Meter(
                                score: _noteController.notes.length,
                                isConstant: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      (size.height * 0.1).gapV,
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => _getNotes(isRefresh: true),
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: _noteController.notes
                                  .map(
                                    (n) => NoteTile(note: n),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
