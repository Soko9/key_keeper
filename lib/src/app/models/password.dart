import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';
import '../../core/helpers/encryption_helper.dart';
import '../../core/utils/utils.dart';

abstract class PasswordFields {
  static const String id = 'password_id';
  static const String password = 'password';
  static const String username = 'username';
  static const String dateTimeCreated = 'date_time_created';
  static const String lastTimeUpdated = 'last_time_updated';
  static const String icon = 'icon';
  static const String userID = 'user_id';
}

class Password extends Equatable {
  final String id;
  final String password;
  final String username;
  final DateTime dateTimeCreated;
  final DateTime lastTimeUpdated;
  final PlatformIcon icon;

  const Password({
    required this.id,
    required this.password,
    required this.username,
    required this.dateTimeCreated,
    required this.lastTimeUpdated,
    required this.icon,
  });

  @override
  List<Object?> get props => [id];

  Password copyWith({
    String? id,
    String? password,
    String? username,
    DateTime? dateTimeCreated,
    DateTime? lastTimeUpdated,
    PlatformIcon? icon,
  }) =>
      Password(
        id: id ?? this.id,
        password: password ?? this.password,
        username: username ?? this.username,
        dateTimeCreated: dateTimeCreated ?? this.dateTimeCreated,
        lastTimeUpdated: lastTimeUpdated ?? this.lastTimeUpdated,
        icon: icon ?? this.icon,
      );

  int get length => password.length;

  int getExpiresIn(int days) =>
      days - DateTime.now().difference(lastTimeUpdated).inDays;

  bool getNeedUpdate(int days) => getExpiresIn(days) <= 5;

  String get createdAt => Jiffy.parseFromDateTime(dateTimeCreated).yMMMEdjm;
  String get updatedAt => Jiffy.parseFromDateTime(lastTimeUpdated).yMMMEdjm;

  PasswordStrength get strength => PasswordStrength.strength(password);

  Map<String, dynamic> toMap({required String userID}) {
    return <String, dynamic>{
      PasswordFields.id: id,
      PasswordFields.password: EncryptionHelper.encrypt(password),
      PasswordFields.username: username,
      PasswordFields.dateTimeCreated: dateTimeCreated.millisecondsSinceEpoch,
      PasswordFields.lastTimeUpdated: lastTimeUpdated.millisecondsSinceEpoch,
      PasswordFields.icon: icon.name,
      PasswordFields.userID: userID,
    };
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map[PasswordFields.id] as String,
      password:
          EncryptionHelper.decrypt(map[PasswordFields.password] as String),
      username: map[PasswordFields.username] as String,
      dateTimeCreated: DateTime.fromMillisecondsSinceEpoch(
          map[PasswordFields.dateTimeCreated] as int),
      lastTimeUpdated: DateTime.fromMillisecondsSinceEpoch(
          map[PasswordFields.lastTimeUpdated] as int),
      icon: PlatformIcon.getIcon(map[PasswordFields.icon] as String),
    );
  }

  // String toJson({required String userID}) => json.encode(toMap(userID: userID));

  // factory Password.fromJson(String source) => Password.fromMap(
  //       json.decode(source) as Map<String, dynamic>,
  //     );
}
