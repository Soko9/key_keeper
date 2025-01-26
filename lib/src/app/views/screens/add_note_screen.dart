import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/home_screen.dart';
import '../../controllers/controllers.dart';
import '../../models/models.dart';
import '../widgets/widgets.dart';
import '../../../core/errors/errors.dart';
import '../../../core/utils/utils.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  AuthController get _authController => Get.find<AuthController>();
  NoteController get _noteController => Get.find<NoteController>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _note = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.note != null) _populateForm();
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  void _populateForm() {
    _title.text = widget.note!.title;
    _note.text = widget.note!.note;
    setState(() {});
  }

  void _reset() {
    _title.clear();
    _note.clear();
    setState(() {});
  }

  Future<void> _upsertNote() async {
    _noteController.clearError();
    if (_formKey.currentState!.validate()) {
      if (widget.note != null) {
        final nt = widget.note!.copyWith(
          title: _title.text.trim(),
          note: _note.text.trim(),
          lastTimeUpdated: DateTime.now(),
        );
        await _noteController.updateNote(
          note: nt,
          id: _authController.currentID,
        );
        Get.offAllNamed(HomeScreen.routeName);
      } else {
        await _noteController.addNote(
          title: _title.text.trim(),
          note: _note.text.trim(),
          userID: _authController.currentID,
        );
      }
      _reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    final bool isUpdating = widget.note != null;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.15,
                    child: CustomPaint(
                      painter: _HeaderPainter(color: theme.colorScheme.primary),
                    ),
                  ),
                  Expanded(
                    child: _noteController.isLoading
                        ? const Loader()
                        : SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                spacing: 16.0,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (_noteController.error.isNotEmpty)
                                    ErrorMessage(
                                      message: _noteController.error,
                                    ),
                                  Text(
                                    '.NOTE.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _title,
                                    decoration: InputDecoration(
                                      hintText: 'Title',
                                      hintStyle: theme
                                          .inputDecorationTheme.hintStyle
                                          ?.copyWith(
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title Is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: _note,
                                    decoration: const InputDecoration(
                                      hintText: 'Note',
                                    ),
                                    maxLines: 12,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Note Is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                  8.gapV,
                                  ElevatedButton(
                                    onPressed: _upsertNote,
                                    child: Text(
                                        '${isUpdating ? 'update' : 'add'} note'),
                                  ),
                                  100.gapV,
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  final Color color;
  const _HeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(size.width * 0.5, size.height * 1.25, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
