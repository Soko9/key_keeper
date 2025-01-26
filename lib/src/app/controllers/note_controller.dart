import 'package:get/get.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  final NoteService noteService;
  NoteController({required this.noteService});

  @override
  void onInit() {
    notes.cast();
    super.onInit();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = ''.obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() => _error.value = '';

  final RxList<Note> _notes = List<Note>.empty(growable: true).obs;
  List<Note> get notes => _notes;
  set notes(List<Note> value) => _notes.value = value;

  void addNt(Note nt) {
    _notes.add(nt);
  }

  void removeNt(Note nt) {
    _notes.remove(nt);
  }

  void updateNt(Note nt) {
    final index = _notes.indexWhere((n) => n.id == nt.id);
    _notes[index] = nt;
  }

  Future<void> getAllNotes({
    required String id,
    bool isRefresh = false,
  }) async {
    if (notes.isNotEmpty && !isRefresh) return;

    isLoading = true;
    clearError();

    final either = await noteService.getAllNotes(id: id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (ntList) {
        notes = ntList;
      },
    );

    isLoading = false;
  }

  Future<void> addNote({
    required String title,
    required String note,
    required String userID,
  }) async {
    isLoading = true;
    clearError();

    final nt = Note(
      id: const Uuid().v4(),
      title: title,
      note: note,
      dateTimeCreated: DateTime.now(),
      lastTimeUpdated: DateTime.now(),
    );

    final either = await noteService.addNewPNote(
      note: nt,
      id: userID,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (nt) {
        addNt(nt);
      },
    );

    isLoading = false;
  }

  Future<void> updateNote({
    required Note note,
    required String id,
  }) async {
    isLoading = true;
    clearError();

    final either = await noteService.updateNote(
      note: note,
      id: id,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (nt) {
        updateNt(nt);
      },
    );

    isLoading = false;
  }

  Future<void> deleteNote({
    required Note note,
  }) async {
    isLoading = true;
    clearError();

    final either = await noteService.deleteNote(id: note.id);
    either.fold(
      (failure) {
        error = failure.message;
      },
      (done) {
        if (done) {
          removeNt(note);
        }
      },
    );

    isLoading = false;
  }
}
