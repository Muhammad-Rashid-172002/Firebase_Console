import 'package:chatnow/Views/compounts/screen/chat_model/chatting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalChats extends StatefulWidget {
  final String email;
  final String uid;

  const PersonalChats({super.key, required this.email, required this.uid});

  @override
  State<PersonalChats> createState() => _PersonalChatsState();
}

class _PersonalChatsState extends State<PersonalChats> {
  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? currentUserId;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId = user.uid;
      currentUserEmail = user.email;
    }
  }

  Future<void> pickMedia() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      await uploadMedia(File(pickedFile.path));
    }
  }

  Future<void> uploadMedia(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child(
        'chat_media/$fileName',
      );
      UploadTask uploadTask = ref.putFile(file);

      final snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await sendMessage(mediaUrl: downloadUrl);
    } catch (e) {
      print("Upload error: $e");
    }
  }

  Future<void> sendMessage({String? mediaUrl}) async {
    if ((messageController.text.trim().isEmpty && mediaUrl == null) ||
        currentUserId == null)
      return;

    final message = ChattingModel(
      senderId: currentUserId!,
      senderEmail: currentUserEmail ?? "Unknown",
      recieverId: widget.uid,
      message: messageController.text.trim(),
      timestamp: Timestamp.now(),
      imageUrl: mediaUrl ?? "No image",
    );

    final ids = [currentUserId!, widget.uid]..sort();
    final chatRoomId = ids.join("_");

    await FirebaseFirestore.instance
        .collection('chatting')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toMap());

    messageController.clear();
  }

  Stream<QuerySnapshot> getMessages() {
    if (currentUserId == null) return const Stream.empty();
    final ids = [currentUserId!, widget.uid]..sort();
    final chatRoomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection('chatting')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Widget buildMessage(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final isCurrentUser = data['senderId'] == currentUserId;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.teal.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            data['imageUrl'] != null && data['imageUrl'] != "No image"
                ? Image.network(data['imageUrl'], width: 200)
                : Text(data['message'], style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget buildMessagesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Center(child: Text("Error loading messages"));
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return const Center(child: Text("No messages yet"));

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: snapshot.data!.docs.map(buildMessage).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.email}'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(child: buildMessagesList()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(onPressed: pickMedia, icon: const Icon(Icons.image)),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => sendMessage(),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
