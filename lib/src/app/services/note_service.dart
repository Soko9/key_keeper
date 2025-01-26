import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import '../models/models.dart';
import '../../core/errors/app_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteService extends GetxService {
  final SupabaseClient supabaseClient;

  NoteService({required this.supabaseClient});

  static const String _tableNotes = 'notes';

  Future<Either<AppFailure, List<Note>>> getAllNotes({
    required String id,
  }) async {
    try {
      //? REMOTE
      final dbNotes = await supabaseClient
          .from(_tableNotes)
          .select()
          .eq(NoteFields.userID, id);

      final notes = dbNotes.map((n) => Note.fromMap(n)).toList();
      return Right(notes);

      //? LOCAL
      // final passwords = await localDB.getAllPasswords();
      // return Right(passwords);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, Note>> addNewPNote({
    required Note note,
    required String id,
  }) async {
    try {
      //? REMOTE
      final dbNote = await supabaseClient
          .from(_tableNotes)
          .insert(note.toMap(userID: id))
          .select()
          .single();

      final nt = Note.fromMap(dbNote);
      return Right(nt);

      //? LOCAL
      // final pass = await localDB.addNewPassword(
      //   password: password,
      //   userID: id,
      // );
      // return Right(pass);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, Note>> updateNote({
    required Note note,
    required String id,
  }) async {
    try {
      final dbNote = await supabaseClient
          .from(_tableNotes)
          .update(note.toMap(userID: id))
          .eq(NoteFields.id, note.id)
          .select()
          .single();

      final nt = Note.fromMap(dbNote);
      return Right(nt);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, bool>> deleteNote({
    required String id,
  }) async {
    try {
      await supabaseClient.from(_tableNotes).delete().eq(NoteFields.id, id);

      return const Right(true);
    } on PostgrestException catch (e) {
      return Left(AppFailure(message: e.message));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
