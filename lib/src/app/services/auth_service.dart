import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import '../../core/errors/errors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxService {
  final SupabaseClient supabaseClient;
  AuthService({required this.supabaseClient});

  static const String _questionKey = 'question';
  static const String _answerKey = 'answer';

  Future<Either<AppFailure, String>> register({
    required String email,
    required String password,
    required String question,
    required String answer,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          _questionKey: question,
          _answerKey: answer,
        },
      );
      if (response.user == null) {
        return Left(AppFailure(message: 'Error Registering User'));
      }
      return Right(response.user!.id);
    } on AuthException catch (e) {
      return Left(AppFailure(message: e.message));
    } on SocketException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, String>> login({
    required String email,
    required String password,
    required String question,
    required String answer,
  }) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        return Left(AppFailure(message: 'No User Found'));
      }

      if (response.user!.userMetadata == null) {
        return left(AppFailure(message: 'No User Meta Data Found!'));
      }

      if (response.user!.userMetadata![_questionKey] != question ||
          response.user!.userMetadata![_answerKey] != answer) {
        return left(
            AppFailure(message: 'Security Question or Answer is Incorrect!'));
      }

      return Right(response.user!.id);
    } on AuthException catch (e) {
      return Left(AppFailure(message: e.message));
    } on SocketException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  Future<Either<AppFailure, bool>> updateMasterPassword({
    required String newMasterPassword,
  }) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(
          password: newMasterPassword,
        ),
      );
      return const Right(true);
    } on AuthException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> updateSecurityQA({
    required String newQuestion,
    required String newAnswer,
  }) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(
          data: {
            _questionKey: newQuestion,
            _answerKey: newAnswer,
          },
        ),
      );
      return const Right(true);
    } on AuthException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<void> sendToken({required String email}) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  Future<Either<AppFailure, String>> verifyOTP({
    required String email,
    required String newPassword,
    required String newQuestion,
    required String newAnswer,
    required String token,
  }) async {
    await supabaseClient.auth.verifyOTP(
      type: OtpType.recovery,
      email: email,
      token: token,
    );

    await updateMasterPassword(newMasterPassword: newPassword);
    await updateSecurityQA(
      newQuestion: newQuestion,
      newAnswer: newAnswer,
    );

    return login(
      email: email,
      password: newPassword,
      question: newQuestion,
      answer: newAnswer,
    );
  }
}
