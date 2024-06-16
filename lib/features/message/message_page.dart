import 'package:facebook_clone/common/styles.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/repositories/user_repo.dart';
import 'package:facebook_clone/utils/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _userRepo = UserRepo();
  final _localStorage = LocalStorage();

  List<User> _matchedUsers = [];

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() async {
    String currentUserId = await _localStorage.read('userId');
    List<User> users = await _userRepo.getMatchedListById(currentUserId);
    setState(() {
      _matchedUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Matches',
              style: AppStyles.bold20,
            ),
          ),
          Expanded(
            child: _matchedUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: _matchedUsers.length,
                    itemBuilder: (context, index) {
                      User user = _matchedUsers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avtUrl),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.bio),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navigate to a chat screen or perform other actions
                          // when the user taps on the ListTile
                          print('Tapped on ${user.name}');
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('You haven\'t matched anyone'),
                  ),
          ),
        ],
      ),
    );
  }
}
