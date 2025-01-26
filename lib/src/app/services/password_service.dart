import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/services/sharable_service.dart';
import '../models/models.dart';
import '../../core/errors/app_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PasswordService extends GetxService {
  final SupabaseClient supabaseClient;
  final SharableService sharableService;

  PasswordService({
    required this.supabaseClient,
    required this.sharableService,
  });

  static const String _tablePasswords = 'passwords';

  Future<Either<AppFailure, List<Password>>> getAllPasswords({
    required String id,
  }) async {
    try {
      final dbPasswords = await supabaseClient
          .from(_tablePasswords)
          .select()
          .eq(PasswordFields.userID, id);

      final passwords = dbPasswords.map((p) => Password.fromMap(p)).toList();
      return Right(passwords);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, Password>> addNewPassword({
    required Password password,
    required String id,
  }) async {
    try {
      final dbPassword = await supabaseClient
          .from(_tablePasswords)
          .insert(password.toMap(userID: id))
          .select()
          .single();

      final pass = Password.fromMap(dbPassword);
      return Right(pass);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, Password>> updatePassword({
    required Password password,
    required String userID,
  }) async {
    try {
      final dbPassword = await supabaseClient
          .from(_tablePasswords)
          .update(password.toMap(userID: userID))
          .eq(PasswordFields.id, password.id)
          .select()
          .single();

      final pass = Password.fromMap(dbPassword);
      return Right(pass);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> deletePasssword({
    required String id,
  }) async {
    try {
      await sharableService.deleteSharableFromPassword(id: id);
      await supabaseClient
          .from(_tablePasswords)
          .delete()
          .eq(PasswordFields.id, id);

      return const Right(true);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
