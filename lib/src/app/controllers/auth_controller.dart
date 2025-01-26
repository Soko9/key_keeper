import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/home_screen.dart';
import '../services/auth_service.dart';
import '../views/screens/screens.dart';

class AuthController extends GetxController {
  final AuthService authService;
  AuthController({required this.authService});

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = ''.obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() => _error.value = '';

  final RxString _currentID = ''.obs;
  String get currentID => _currentID.value;
  set currentID(String value) => _currentID.value = value;

  Future<void> register({
    required String email,
    required String password,
    required String question,
    required String answer,
  }) async {
    isLoading = true;
    clearError();

    final either = await authService.register(
      email: email,
      password: password,
      question: question,
      answer: answer,
    );
    either.fold(
      (failure) {
        error = failure.message;
      },
      (id) {
        currentID = id;
        Get.offAllNamed(HomeScreen.routeName);
      },
    );

    isLoading = false;
  }

  Future<void> login({
    required String email,
    required String password,
    required String question,
    required String answer,
  }) async {
    isLoading = true;
    clearError();

    final either = await authService.login(
      email: email,
      password: password,
      question: question,
      answer: answer,
    );
    either.fold(
      (failure) {
        error = failure.message;
      },
      (id) {
        currentID = id;
        Get.offAllNamed(HomeScreen.routeName);
      },
    );

    isLoading = false;
  }

  Future<void> logout() async {
    await authService.logout();
    currentID = '';
    Get.offAllNamed(AuthScreen.routeName);
  }

  Future<void> updateMasterPassword({
    required String newMasterPassword,
  }) async {
    isLoading = true;
    clearError();

    final either = await authService.updateMasterPassword(
      newMasterPassword: newMasterPassword,
    );
    either.fold(
      (failure) {
        error = failure.message;
      },
      (_) async {
        await logout();
      },
    );

    isLoading = false;
  }

  Future<void> updateSecurityQA({
    required String newQuestion,
    required String newAnswer,
  }) async {
    isLoading = true;
    clearError();

    final either = await authService.updateSecurityQA(
      newQuestion: newQuestion,
      newAnswer: newAnswer,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (_) async {
        await logout();
      },
    );

    isLoading = false;
  }

  final RxBool _emailSent = false.obs;
  bool get emailSent => _emailSent.value;
  set emailSent(bool value) => _emailSent.value = value;

  Future<void> sendToken({required String email}) async {
    isLoading = true;
    await authService.sendToken(email: email);
    emailSent = true;
    isLoading = false;
  }

  Future<void> verifyOTP({
    required String email,
    required String newPassword,
    required String newQuestion,
    required String newAnswer,
    required String token,
  }) async {
    isLoading = true;
    clearError();

    final either = await authService.verifyOTP(
      email: email,
      newPassword: newPassword,
      newQuestion: newQuestion,
      newAnswer: newAnswer,
      token: token,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (id) {
        emailSent = false;
        currentID = id;
        Get.offAllNamed(HomeScreen.routeName);
      },
    );

    isLoading = false;
  }
}
