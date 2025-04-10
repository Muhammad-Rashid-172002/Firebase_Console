import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/Profile_screen.dart';
import 'package:chatnow/Views/compounts/screen/home/chats/personal_Chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [Chats(), Status(), Calls()];

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
          print('Tapped BottomNavigationBar index: $index');
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Stream<QuerySnapshot> getUsersData() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print("No current user found.");
      return Stream.empty();
    }

    print("Fetching users excluding current user -----> ${currentUser.uid}");

    return FirebaseFirestore.instance
        .collection('chatting_users')
        .where('uid', isNotEqualTo: currentUser.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              }
            },
            itemBuilder:
                (context) => const [
                  PopupMenuItem(value: "Profile", child: Text('Profile')),
                ],
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getUsersData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Snapshot error ----> ${snapshot.error}');
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print('No users found in snapshot.');
            return const Center(child: Text('No users found'));
          }

          var userData = snapshot.data!.docs;
          print('Total users fetched  -----> ${userData.length}');

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              var showData = userData[index].data() as Map<String, dynamic>;
              print(
                'User ${index + 1}----> Email = ${showData['uEmail']}, UID = ${showData['uid']}',
              );

              return ListTile(
                onTap: () {
                  print('Tapped on user -----> ${showData['uEmail']}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PersonalChats(
                            email: showData['uEmail'],
                            uid: showData['uid'],
                          ),
                    ),
                  );
                },
                leading: const Icon(Icons.person),
                title: Text(showData['uEmail']),
                subtitle: Text(showData['uid']),
              );
            },
          );
        },
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    print("Status screen built.");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const Center(child: Text('Status Updates')),
    );
  }
}

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    print("Calls screen built.");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Calls',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const Center(child: Text('No call history available')),
    );
  }
}
