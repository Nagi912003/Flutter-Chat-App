import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:chat_app/widgets/image_picker/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Chat',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: const Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
      drawer: Drawer(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const UserImagePicker(),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FetchedUserNameWidget(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          FirebaseAuth.instance.currentUser!.email != null
                              ? FirebaseAuth.instance.currentUser!.email!
                              : 'User Email',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FetchedUserNameWidget extends StatefulWidget {
  const FetchedUserNameWidget({Key? key}) : super(key: key);

  @override
  State<FetchedUserNameWidget> createState() => _FetchedUserNameWidgetState();
}

class _FetchedUserNameWidgetState extends State<FetchedUserNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      FirebaseAuth.instance.currentUser!.displayName != null
          ? FirebaseAuth.instance.currentUser!.displayName!
          : 'User Name...',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

