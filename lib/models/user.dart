import 'dart:convert';

class User {
  final String id;
  final String name;
  final String user_id;
  final String senha;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.user_id,
    required this.senha,
    required this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'user_id': user_id});
    result.addAll({'senha': senha});
    result.addAll({'avatarUrl': avatarUrl});

    return result;
  }

  User copyWith({
    String? id,
    String? name,
    String? user_id,
    String? senha,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      user_id: user_id ?? this.user_id,
      senha: senha ?? this.senha,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      user_id: map['user_id'] ?? '',
      senha: map['senha'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, user_id: $user_id, senha: $senha, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.user_id == user_id &&
        other.senha == senha &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        user_id.hashCode ^
        senha.hashCode ^
        avatarUrl.hashCode;
  }
}
