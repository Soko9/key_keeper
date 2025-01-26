import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_secrets.dart';
import 'src/app/controllers/controllers.dart';
import 'src/app/services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    await Supabase.initialize(
      url: AppSecrets.suspabaseUrl,
      anonKey: AppSecrets.supabaseAnonKey,
    );

    Get.put<SupabaseClient>(Supabase.instance.client);

    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs);

    // Services
    Get.put<AuthService>(
      AuthService(supabaseClient: Get.find<SupabaseClient>()),
    );

    Get.put<SharableService>(
      SharableService(supabaseClient: Get.find<SupabaseClient>()),
    );

    Get.put<PasswordService>(
      PasswordService(
        supabaseClient: Get.find<SupabaseClient>(),
        sharableService: Get.find<SharableService>(),
      ),
    );

    Get.put<NoteService>(
      NoteService(supabaseClient: Get.find<SupabaseClient>()),
    );

    Get.put<SettingsService>(
      SettingsService(preferences: Get.find<SharedPreferences>()),
    );

    // Controllers
    Get.put<AuthController>(
      AuthController(authService: Get.find<AuthService>()),
    );

    Get.put<PasswordController>(
      PasswordController(passwordService: Get.find<PasswordService>()),
    );

    Get.put<NoteController>(
      NoteController(noteService: Get.find<NoteService>()),
    );

    Get.put<SharableController>(
      SharableController(sharableService: Get.find<SharableService>()),
    );
  }
}
