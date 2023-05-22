import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    FirebaseFirestore.instance.collection('chats/JoHuvw3m9qcg9KL9ue5z/chat').add({
      'text':_enteredMessage,
      'createdAt':Timestamp.now(),
      'userId': userId,
      'username': userData['username'],
    });
    // Send message
    _controller.clear();
    _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Message...'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null: _sendMessage,
          ),
        ],
      ),
    );
  }
}
