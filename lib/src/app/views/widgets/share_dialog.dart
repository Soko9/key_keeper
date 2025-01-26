import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/controllers/controllers.dart';
import 'package:key_keeper/src/app/models/models.dart';
import 'package:key_keeper/src/app/views/widgets/widgets.dart';
import 'package:key_keeper/src/core/errors/errors.dart';

class ShareDialog extends StatefulWidget {
  final Password password;

  const ShareDialog({super.key, required this.password});

  @override
  State<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  AuthController get _authController => Get.find<AuthController>();
  SharableController get _sharableController => Get.find<SharableController>();

  final TextEditingController _id = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _id.dispose();
    super.dispose();
  }

  Future<void> _share() async {
    if (_formKey.currentState!.validate()) {
      await _sharableController.sharePassword(
        senderID: _authController.currentID,
        recieverID: _id.text.trim(),
        password: widget.password,
      );
      _id.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2.0, color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(16.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: Obx(
        () => _sharableController.isLoading
            ? const SizedBox.square(
                dimension: 200.0,
                child: Loader(),
              )
            : Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12.0,
                  children: [
                    if (_sharableController.error.isNotEmpty)
                      ErrorMessage(message: _sharableController.error),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _id,
                        decoration:
                            const InputDecoration(hintText: 'Reciever ID'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ID is Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _share,
                      child: const Text('share'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
