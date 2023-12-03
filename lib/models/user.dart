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
    return {
      'id': id,
      'name': name,
      'user_id': user_id,
      'senha': senha,
      'avatarUrl': avatarUrl,
    };
  }
}
