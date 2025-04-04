import 'package:chatnow/Views/compounts/screen/chat_model/chatting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalChats extends StatefulWidget {
  final String email;
  final String uid;
  const PersonalChats({super.key, required this.email, required this.uid});

  @override
  State<PersonalChats> createState() => _PersonalChatsState();
}

class _PersonalChatsState extends State<PersonalChats> {
  final messageController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  // Send message
  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    ChattingModel newMessage = ChattingModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail.toString(),
      recieverId: widget.uid,
      message: messageController.text,
      timestamp: Timestamp.now(),
    );

    List<String> ids = [currentUserId, widget.uid];
    ids.sort();
    final combineIds = ids.join("_");

    await FirebaseFirestore.instance
        .collection(
          'smit_chatting',
        ) // Ensure this collection name matches Firebase
        .doc(combineIds)
        .collection('smit_messages')
        .add(newMessage.toMap());

    messageController.clear();
  }

  // Get messages
  Stream<QuerySnapshot> getMessages() {
    List<String> ids = [currentUserId, widget.uid];
    ids.sort();
    final combineIds = ids.join("_");

    return FirebaseFirestore.instance
        .collection(
          'smit_chatting',
        ) // Ensure this collection name matches Firebase
        .doc(combineIds)
        .collection('smit_messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.email), backgroundColor: Colors.teal),
      body: Column(
        children: [
          Expanded(child: buildMessagesList()), // Wrap in Expanded
          buildUserPrompt(),
        ],
      ),
    );
  }

  // Text Input
  Widget buildUserPrompt() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Enter message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }

  // Display Single Message
  Widget buildMessage(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == currentUserId;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.teal.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(data['message'], style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  // Display List of Messages
  Widget buildMessagesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading messages'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet'));
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessage(doc)).toList(),
        );
      },
    );
  }
}
