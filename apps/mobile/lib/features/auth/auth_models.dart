class CurrentUser {
  CurrentUser({
    required this.id,
    required this.username,
    required this.name,
    required this.position,
    required this.role,
    this.community,
    this.avatarUrl,
  });

  final String id;
  final String username;
  final String name;
  final String position;
  final String role;
  final String? community;
  final String? avatarUrl;

  factory CurrentUser.fromJson(Map<String, dynamic> json) => CurrentUser(
        id: json['id'] as String,
        username: json['username'] as String,
        name: json['name'] as String,
        position: json['position'] as String,
        role: json['role'] as String,
        community: json['community'] as String?,
        avatarUrl: json['avatarUrl'] as String?,
      );

  CurrentUser copyWith({
    String? name,
    String? position,
    String? community,
    String? avatarUrl,
  }) {
    return CurrentUser(
      id: id,
      username: username,
      name: name ?? this.name,
      position: position ?? this.position,
      role: role,
      community: community ?? this.community,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
