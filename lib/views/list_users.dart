import 'package:flutter/material.dart';
import 'package:myapp/data/mock_users.dart';
import 'package:myapp/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.orange,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> displayedUsers = List.from(MOCK_USERS.values);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 51, 99, 1),
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch<String>(
                context: context,
                delegate: UserSearchDelegate(userList: displayedUsers),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: displayedUsers.length,
        itemBuilder: (context, index) {
          User user = displayedUsers[index];
          return _buildUserTile(user);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await _showAddUserDialog(context);
          if (newUser != null) {
            setState(() {
              displayedUsers.add(newUser);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildUserTile(User user) {
    return ListTile(
      title: Text(
        user.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        user.user_id,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final editedUser = await _showEditUserDialog(context, user);
              if (editedUser != null) {
                _updateUser(editedUser);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteUser(context, user);
            },
          ),
        ],
      ),
    );
  }

  Future<User?> _showEditUserDialog(BuildContext context, User user) async {
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final TextEditingController userIdController =
        TextEditingController(text: user.user_id);
    final TextEditingController avatarUrlController =
        TextEditingController(text: user.avatarUrl);

    return await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: userIdController,
                  decoration: InputDecoration(labelText: 'User ID'),
                ),
                TextField(
                  controller: avatarUrlController,
                  decoration: InputDecoration(labelText: 'Avatar URL'),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final editedUser = User(
                          id: user.id,
                          name: nameController.text,
                          user_id: userIdController.text,
                          senha: user.senha,
                          avatarUrl: avatarUrlController.text,
                        );
                        Navigator.of(context).pop(editedUser);
                      },
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<User?> _showAddUserDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController userIdController = TextEditingController();
    final TextEditingController avatarUrlController = TextEditingController();

    return await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: userIdController,
                  decoration: InputDecoration(labelText: 'User ID'),
                ),
                TextField(
                  controller: avatarUrlController,
                  decoration: InputDecoration(labelText: 'Avatar URL'),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final newUser = User(
                          id: UniqueKey().toString(),
                          name: nameController.text,
                          user_id: userIdController.text,
                          senha: '123456',
                          avatarUrl: avatarUrlController.text,
                        );
                        Navigator.of(context).pop(newUser);
                      },
                      child: Text('Add User'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteUser(BuildContext context, User user) {
    setState(() {
      displayedUsers.remove(user);
    });
  }

  void _updateUser(User editedUser) {
    setState(() {
      final index =
          displayedUsers.indexWhere((user) => user.id == editedUser.id);
      if (index != -1) {
        displayedUsers[index] = editedUser;
      }
    });
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final List<User> userList;

  UserSearchDelegate({required this.userList});

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<User> results = userList
        .where((user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.user_id.toLowerCase().contains(query.toLowerCase()) ||
            user.id.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final User user = results[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.user_id),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          onTap: () {
            close(context, user.user_id);
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }
}
