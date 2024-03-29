import 'badge.dart';

class Profile {
  final String id;
  final String? avatar;
  final String nickname;
  final Badge? badge;
  final String role;
  final String position;
  final int temperature;

  Profile({
    required this.id,
    this.avatar,
    required this.nickname,
    this.badge,
    required this.role,
    required this.position,
    required this.temperature,
  });

  factory Profile.fromMap(Map<String, dynamic> map) => Profile(
        id: map['id'],
        avatar: map['avatar'],
        nickname: map['nickname'],
        badge: map['badge'] != null ? Badge.fromMap(map['badge']) : null,
        role: map['role'],
        position: map['position'],
        temperature: map['temperature'],
      );
}
