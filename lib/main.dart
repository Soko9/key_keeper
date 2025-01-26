import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/widgets/widgets.dart';
import 'src/app/controllers/controllers.dart';
import 'src/app/services/services.dart';
import 'src/app/views/screens/screens.dart';
import 'src/core/errors/network_failed_screen.dart';
import 'app_bindings.dart';
import 'src/config/app_navigation.dart';
import 'src/config/app_theme.dart';

//? BACKUP UP RECOVERY

//* DESKTOP SUPPORT

//! BROWSER EXTENSION
//! AUTO-LOGIN & AUTO-FILL
//! FAMILY/TEAM PLANS & ROLE ACCESS CONTROL (ADMIN, MEMBER, VIEWER)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings().dependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put<SettingsController>(
      SettingsController(settingsService: Get.find<SettingsService>()),
    );

    return Obx(
      () => settingsController.isLoading
          ? const Loader()
          : GetMaterialApp(
              title: 'Key Keeper',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:
                  settingsController.isDark ? ThemeMode.dark : ThemeMode.light,
              home: settingsController.isOnline
                  ? const AuthScreen()
                  : const NetworkFailedScreen(),
              getPages: AppNavigation.pages,
            ),
    );
  }
}
