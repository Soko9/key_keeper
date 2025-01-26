import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/models/models.dart';
import 'package:key_keeper/src/core/errors/app_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SharableService extends GetxService {
  final SupabaseClient supabaseClient;

  SharableService({required this.supabaseClient});

  static const String _tableSharables = 'sharables';
  static const String _viewSharablesWithPasswords = 'sharables_with_passwords';

  Future<Either<AppFailure, List<Sharable>>> getAllSharables({
    required String id,
  }) async {
    try {
      final dbSharables = await supabaseClient
          .from(_viewSharablesWithPasswords)
          .select()
          .or('${SharableFields.senderID}.eq.$id, ${SharableFields.recieverID}.eq.$id');

      final sharables = dbSharables.map((s) => Sharable.fromMap(s)).toList();
      return Right(sharables);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, Sharable>> sharePassword({
    required String senderID,
    required String recieverID,
    required Password password,
  }) async {
    try {
      final sharable = Sharable(
        id: const Uuid().v4(),
        senderID: senderID,
        recieverID: recieverID,
        password: password,
        dateTimeShared: DateTime.now(),
      );

      final sharableMap = await supabaseClient
          .from(_tableSharables)
          .insert(sharable.toMap())
          .select()
          .single();

      final dbSharable = await supabaseClient
          .from(_viewSharablesWithPasswords)
          .select()
          .eq(
            SharableFields.id,
            sharableMap[SharableFields.id],
          )
          .single();

      return right(Sharable.fromMap(dbSharable));
    } on PostgrestException catch (_) {
      return left(AppFailure(message: 'No Such ID Found'));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> deleteSharable({required String id}) async {
    try {
      await supabaseClient
          .from(_tableSharables)
          .delete()
          .eq(SharableFields.id, id);

      return const Right(true);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> deleteSharableFromPassword(
      {required String id}) async {
    try {
      await supabaseClient
          .from(_tableSharables)
          .delete()
          .eq(SharableFields.passwordID, id);

      return const Right(true);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
