import 'package:chatnow/Views/compounts/screen/chats/personschats.dart';
import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/Profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [Chatscreen(), StatusScreen(), CallScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  Stream<QuerySnapshot> getUsersData() {
    String currentUserId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user's UID

    return FirebaseFirestore.instance
        .collection('chatting_users')
        .where('uid', isNotEqualTo: currentUserId) // Exclude current user
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Chats',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "New Group") {
                    Navigator.pushNamed(context, '/newgroup');
                  } else if (value == "Linked Devices") {
                    Navigator.pushNamed(context, '/linkeddevices');
                  } else if (value == "Profile") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: "New Group",
                        child: Text('New Group'),
                      ),
                      const PopupMenuItem(
                        value: "Linked Devices",
                        child: Text('Linked Devices'),
                      ),
                      const PopupMenuItem(
                        value: "Profile",
                        child: Text('Profile'),
                      ),
                    ],
              ),
            ],
          ),
          Expanded(
            // Prevents layout errors
            child: StreamBuilder<QuerySnapshot>(
              stream: getUsersData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data.'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                var userData = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: userData.length,
                  itemBuilder: (context, index) {
                    var showData =
                        userData[index].data() as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Personschats(
                                  email: '${showData['uEmail']}',
                                  uid: '${showData['uid']}',
                                ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Email: ${showData['uEmail']}'),
                        subtitle: Text('UID ${showData['uid']}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Row(
              children: [
                Text(
                  'Status Updates',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Calls',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          const Center(child: Text('No call history available')),
        ],
      ),
    );
  }
}
