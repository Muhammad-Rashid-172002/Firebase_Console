import 'package:chatnow/Views/compounts/screen/chat_model/chatting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Personschats extends StatefulWidget {
  final String email;
  final String uid;
  const Personschats({super.key, required this.email, required this.uid});

  @override
  State<Personschats> createState() => _PersonschatsState();
}

class _PersonschatsState extends State<Personschats> {
  final massageController = TextEditingController();
  final String currentUserEmail = FirebaseAuth.instance.currentUser!.uid;
  final timeStamp = Timestamp.now();

  // sending massages
  Future<void> sendMassage() async {
    print('send Massage ----> $currentUserEmail time $timeStamp');
    ChattingModel newMessage = ChattingModel(
      senderId: currentUserEmail,
      senderEmail: currentUserEmail,
      reciverId: widget.uid,
      message: massageController.text,
      timestamp: timeStamp,
    );
    List<String> ids = [currentUserEmail, widget.uid];
    print('ids-----> $ids');
    ids.sort();
    final combineIds = ids.join("/");
    print('combine Ids----> $combineIds');
    await FirebaseFirestore.instance
        .collection("People_Chats")
        .doc(combineIds)
        .collection('People_Message')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages() {
    List<String> ids = [currentUserEmail, widget.uid];
    print('ids----> $ids');
    ids.sort();
    final combineIds = ids.join("/");
    print('combine ids ---->$combineIds');
    return FirebaseFirestore.instance
        .collection('People_Chats')
        .doc(combineIds)
        .collection('People_Message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: buildMessagesList()), buildUserPrompt()],
      ),
    );
  }

  // user prompt text field
  Widget buildUserPrompt() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: massageController,
            decoration: const InputDecoration(
              hintText: 'enter message',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (massageController.text.isNotEmpty) {
              sendMassage();
              massageController.clear();
            }
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  // single message show
  Widget buildMessage(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == currentUserEmail;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue.shade200 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.7, // Message width limit
          ),
          child: Column(
            children: [
              Text(data['message'], style: TextStyle(fontSize: 16)),
              Text(data['senderEmail'], style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // List of messages show

  Widget buildMessagesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(),
      builder: (context, snapshot) {
        // var data =  snapshot.data as Map<String, dynamic>;
        // print('data --------> ${data.toString()}');

        if (snapshot.hasError) {
          return Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data found');
        }

        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessage(doc)).toList(),
        );
      },
    );
  }
}
