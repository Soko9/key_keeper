import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/widgets/loader.dart';
import 'package:key_keeper/src/app/views/widgets/sharable_tile.dart';

import '../../controllers/controllers.dart';

class SharablesScreen extends StatefulWidget {
  const SharablesScreen({super.key});

  @override
  State<SharablesScreen> createState() => _SharablesScreenState();
}

class _SharablesScreenState extends State<SharablesScreen> {
  AuthController get _authController => Get.find<AuthController>();
  SharableController get _sharableController => Get.find<SharableController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAllSharables();
    });
  }

  Future<void> _getAllSharables({bool isRefresh = false}) async {
    await _sharableController.getAllSharables(
      id: _authController.currentID,
      isRefresh: isRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: size.height * 0.85,
      padding: const EdgeInsets.all(12.0),
      color: theme.scaffoldBackgroundColor,
      child: Obx(
        () => _sharableController.isLoading
            ? const Loader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12.0,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8.0,
                    children: [
                      const Text(
                        'Passwords Shared Log',
                        textAlign: TextAlign.center,
                      ),
                      if (!Platform.isAndroid && !Platform.isIOS)
                        InkWell(
                          onTap: () async => _getAllSharables(isRefresh: true),
                          child: Icon(
                            FontAwesomeIcons.arrowsRotate,
                            size: 10.0,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => _getAllSharables(isRefresh: true),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _sharableController.sharables.length,
                        itemBuilder: (_, index) {
                          final sharable = _sharableController.sharables[index];
                          return SharableTile(sharable: sharable);
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
