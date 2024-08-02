import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GymOwnerHomePage extends StatefulWidget {
  const GymOwnerHomePage({super.key});

  @override
  State<GymOwnerHomePage> createState() => _GymOwnerHomePageState();
}

class _GymOwnerHomePageState extends State<GymOwnerHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _addedUsers = [];
  List<DocumentSnapshot> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAddedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Owner Home Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Users',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _fetchUsers();
                    },
                  ),
                ),
                onChanged: (value) {
                  _fetchUsers();
                },
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                final username = user['username'];
                final isAdded = _addedUsers.contains(username);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        username[0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(username),
                    trailing: ElevatedButton(
                      onPressed: isAdded
                          ? null
                          : () {
                        _addUser(username);
                      },
                      child: Text(isAdded ? 'Added' : 'Add'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAdded ? Colors.grey : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text('Added Users:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _addedUsers.length,
              itemBuilder: (context, index) {
                final username = _addedUsers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        username[0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(username),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        _removeUser(username);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _fetchUsers() {
    setState(() {
      _isLoading = true;
      _users.clear(); // Clear previous search results
    });

    String searchQuery = _searchController.text.trim();

    FirebaseFirestore.instance.collection('users').get().then((snapshot) {
      setState(() {
        _isLoading = false;
        _users = snapshot.docs
            .where((doc) => doc['username']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
            .toList();
      });
    });
  }

  void _fetchAddedUsers() async {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance.collection('gymAddedUsers').get().then((snapshot) {
      setState(() {
        _isLoading = false;
        _addedUsers = snapshot.docs.map((doc) => doc['username'] as String).toList();
      });
    });
  }

  void _addUser(String username) {
    if (!_addedUsers.contains(username)) {
      setState(() {
        _addedUsers.add(username);
      });

      FirebaseFirestore.instance.collection('gymAddedUsers').add({'username': username});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$username added'),
        ),
      );
    }
  }

  void _removeUser(String username) {
    setState(() {
      _addedUsers.remove(username);
    });

    FirebaseFirestore.instance
        .collection('gymAddedUsers')
        .where('username', isEqualTo: username)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$username removed'),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
