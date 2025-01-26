import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';

abstract class NoteFields {
  static const String id = 'note_id';
  static const String title = 'title';
  static const String note = 'note';
  static const String dateTimeCreated = 'date_time_created';
  static const String lastTimeUpdated = 'last_time_updated';
  static const String userID = 'user_id';
}

class Note extends Equatable {
  final String id;
  final String title;
  final String note;
  final DateTime dateTimeCreated;
  final DateTime lastTimeUpdated;

  const Note({
    required this.id,
    required this.title,
    required this.note,
    required this.dateTimeCreated,
    required this.lastTimeUpdated,
  });

  @override
  List<Object?> get props => [id];

  Note copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? dateTimeCreated,
    DateTime? lastTimeUpdated,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        dateTimeCreated: dateTimeCreated ?? this.dateTimeCreated,
        lastTimeUpdated: lastTimeUpdated ?? this.lastTimeUpdated,
      );

  int getExpiresIn(int days) =>
      days - DateTime.now().difference(lastTimeUpdated).inDays;

  bool getNeedUpdate(int days) => getExpiresIn(days) <= 0;

  String get createdAt => Jiffy.parseFromDateTime(dateTimeCreated).yMMMEdjm;
  String get updatedAt => Jiffy.parseFromDateTime(lastTimeUpdated).yMMMEdjm;

  Map<String, dynamic> toMap({required String userID}) => <String, dynamic>{
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.note: note,
        NoteFields.dateTimeCreated: dateTimeCreated.millisecondsSinceEpoch,
        NoteFields.lastTimeUpdated: lastTimeUpdated.millisecondsSinceEpoch,
        NoteFields.userID: userID,
      };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
        id: map[NoteFields.id] as String,
        title: map[NoteFields.title] as String,
        note: map[NoteFields.note] as String,
        dateTimeCreated: DateTime.fromMillisecondsSinceEpoch(
          map[NoteFields.dateTimeCreated] as int,
        ),
        lastTimeUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[NoteFields.lastTimeUpdated] as int,
        ),
      );
}
