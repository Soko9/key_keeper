import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:key_keeper/src/core/utils/app_enums.dart';

import 'password.dart';

abstract class SharableFields {
  static const String id = 'sharable_id';
  static const String senderID = 'sender_id';
  static const String recieverID = 'reciever_id';
  static const String passwordID = 'password_id';
  static const String dateTimeShared = 'date_time_shared';
}

class Sharable extends Equatable {
  final String id;
  final String senderID;
  final String recieverID;
  final Password password;
  final DateTime dateTimeShared;

  const Sharable({
    required this.id,
    required this.senderID,
    required this.recieverID,
    required this.password,
    required this.dateTimeShared,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() => <String, dynamic>{
        SharableFields.id: id,
        SharableFields.senderID: senderID,
        SharableFields.recieverID: recieverID,
        SharableFields.passwordID: password.id,
        SharableFields.dateTimeShared: dateTimeShared.millisecondsSinceEpoch,
      };

  String get sharedAt => Jiffy.parseFromDateTime(dateTimeShared).yMMMEdjm;

  bool isSender(String currentID) => senderID == currentID;

  factory Sharable.fromMap(Map<String, dynamic> map) {
    final password = Password(
      id: map[PasswordFields.id],
      password: map[PasswordFields.password],
      username: map[PasswordFields.username],
      dateTimeCreated: DateTime.fromMillisecondsSinceEpoch(
          map[PasswordFields.dateTimeCreated] as int),
      lastTimeUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[PasswordFields.lastTimeUpdated] as int),
      icon: PlatformIcon.getIcon(map[PasswordFields.icon] as String),
    );

    return Sharable(
      id: map[SharableFields.id] as String,
      senderID: map[SharableFields.senderID] as String,
      recieverID: map[SharableFields.recieverID] as String,
      password: password,
      dateTimeShared: DateTime.fromMillisecondsSinceEpoch(
        map[SharableFields.dateTimeShared] as int,
      ),
    );
  }
}
