class BestSpacer {
  final String id;
  final String? avatar; // avatar는 null일 수도 있으므로 String?로 선언
  final String nickname;
  final String role;
  final String position;
  final int temperature;

  BestSpacer({
    required this.id,
    this.avatar,
    required this.nickname,
    required this.role,
    required this.position,
    required this.temperature,
  });

  // JSON을 User 객체로 변환하는 팩토리 생성자
  factory BestSpacer.fromMap(Map<String, dynamic> map) {
    return BestSpacer(
      id: map['id'],
      avatar: map['avatar'],
      nickname: map['nickname'],
      role: map['role'],
      position: map['position'],
      temperature: map['temperature'],
    );
  }
}
