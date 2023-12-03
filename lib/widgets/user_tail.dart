import 'package:myapp/models/user.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
        leading: avatar,
        title: Text(user.name),
        subtitle: Text(user.user_id),
        trailing: Wrap(
          children: <Widget>[
            IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          ],
        ));
  }
}
