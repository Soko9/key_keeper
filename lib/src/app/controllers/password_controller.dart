import 'package:get/get.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../../core/utils/utils.dart';
import 'package:uuid/uuid.dart';

class PasswordController extends GetxController {
  final PasswordService passwordService;
  PasswordController({required this.passwordService});

  @override
  void onInit() {
    passwords.clear();
    super.onInit();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = ''.obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() => _error.value = '';

  final RxList<Password> _passwords = List<Password>.empty(growable: true).obs;
  List<Password> get passwords => _passwords;
  set passwords(List<Password> value) => _passwords.value = value;

  int get strong =>
      passwords.where((p) => p.strength == PasswordStrength.strong).length;

  int get good =>
      passwords.where((p) => p.strength == PasswordStrength.good).length;

  int get fair =>
      passwords.where((p) => p.strength == PasswordStrength.fair).length;

  int get weak =>
      passwords.where((p) => p.strength == PasswordStrength.weak).length;

  int get score {
    double strongs = strong * 3;
    double goods = good * 2;

    double total = (strongs + goods + fair) / (passwords.length * 3);

    if (total.isNaN) total = 0;
    return (total * 100).toInt();
  }

  void addPass(Password pass) {
    _passwords.add(pass);
  }

  void removePass(Password pass) {
    _passwords.remove(pass);
  }

  void updatePass(Password pass) {
    final index = _passwords.indexWhere((p) => p.id == pass.id);
    _passwords[index] = pass;
  }

  Future<void> getAllPasswords({
    required String id,
    bool isRefresh = false,
  }) async {
    if (passwords.isNotEmpty && !isRefresh) return;

    isLoading = true;
    clearError();

    final either = await passwordService.getAllPasswords(id: id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (passList) {
        passwords = passList;
      },
    );

    isLoading = false;
  }

  Future<void> addPassword({
    required String password,
    required String username,
    required PlatformIcon icon,
    required String userID,
  }) async {
    isLoading = true;
    clearError();

    final pass = Password(
      id: const Uuid().v4(),
      password: password,
      username: username,
      dateTimeCreated: DateTime.now(),
      lastTimeUpdated: DateTime.now(),
      icon: icon,
    );

    final either = await passwordService.addNewPassword(
      password: pass,
      id: userID,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (pass) {
        addPass(pass);
      },
    );

    isLoading = false;
  }

  Future<void> updatePassword({
    required Password password,
    required String userID,
  }) async {
    isLoading = true;
    clearError();

    final either = await passwordService.updatePassword(
      password: password,
      userID: userID,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (pass) {
        updatePass(pass);
      },
    );

    isLoading = false;
  }

  Future<void> deletePassword({
    required Password password,
  }) async {
    isLoading = true;
    clearError();

    final either = await passwordService.deletePasssword(id: password.id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (done) {
        if (done) {
          removePass(password);
        }
      },
    );

    isLoading = false;
  }
}
