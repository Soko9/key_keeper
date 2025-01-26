import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../services/services.dart';
import '../../core/utils/app_enums.dart';

class SettingsController extends GetxController {
  final SettingsService settingsService;
  SettingsController({required this.settingsService});

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = ''.obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() => _error.value = '';

  final RxBool _isOnline = false.obs;
  bool get isOnline => _isOnline.value;
  set isOnline(bool value) => _isOnline.value = value;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubsscription;

  @override
  Future<void> onReady() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    _isDark.value = settingsService.isDark;
    _days.value = settingsService.duration;
    _connectivitySubsscription =
        Connectivity().onConnectivityChanged.listen((event) {
      final List<ConnectivityResult> acceptedConnection = [
        ConnectivityResult.wifi,
        ConnectivityResult.mobile,
        ConnectivityResult.ethernet,
      ];
      isOnline = acceptedConnection.contains(event.last);
    });
    isLoading = false;
    super.onReady();
  }

  @override
  void onClose() {
    _connectivitySubsscription.cancel();
    super.onClose();
  }

  final RxBool _isDark = false.obs;
  bool get isDark => _isDark.value;
  Future<void> setTheme({required bool value}) async {
    await settingsService.setTheme(isDark: value);
    _isDark.value = value;
  }

  final RxInt _days = DeadlineDuration.ninety.duration.obs;
  int get days => _days.value;
  Future<void> setDays({required int value}) async {
    await settingsService.setDuration(duartion: value);
    _days.value = value;
  }
}
