import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(semanticsLabel: 'loading'),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: MessageBubble(
                username: chatDocs[index]['username'],
                message: chatDocs[index]['text'],
                isMe: chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatDocs[index].id),
              ),
            );
          },
          itemCount: chatDocs.length,
          reverse: true,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('chats/JoHuvw3m9qcg9KL9ue5z/chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
