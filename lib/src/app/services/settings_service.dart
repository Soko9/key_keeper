import 'package:get/get.dart';
import '../../core/utils/app_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  final SharedPreferences preferences;
  SettingsService({required this.preferences});

  static const String _prefTheme = 'isDrak';
  static const String _prefDeadlineDurationInDays = 'deadline';

  bool get isDark => preferences.getBool(_prefTheme) ?? false;
  int get duration =>
      preferences.getInt(_prefDeadlineDurationInDays) ??
      DeadlineDuration.ninety.duration;

  Future<void> setTheme({required bool isDark}) async {
    await preferences.setBool(_prefTheme, isDark);
  }

  Future<void> setDuration({required int duartion}) async {
    await preferences.setInt(_prefDeadlineDurationInDays, duartion);
  }
}
