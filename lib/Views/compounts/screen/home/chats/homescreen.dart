import 'dart:io';
import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/Profile_screen.dart';
import 'package:chatnow/Views/compounts/screen/home/chats/personal_Chats.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status1.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status2.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status4.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status5.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status6.dart';
import 'package:chatnow/Views/compounts/screen/home/status/stuats3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      currentUserEmail = currentUser.email;
    }
  }

  Stream<QuerySnapshot> getUsersData() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return Stream.empty();

    return FirebaseFirestore.instance
        .collection('Users')
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
          if (snapshot.hasError)
            return const Center(child: Text('Something went wrong'));
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          var userData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              var user = userData[index].data() as Map<String, dynamic>;
              String profilePicUrl = user['profilePicUrl'] ?? '';

              return ListTile(
                leading:
                    profilePicUrl.isNotEmpty
                        ? CircleAvatar(
                          backgroundImage: NetworkImage(profilePicUrl),
                        )
                        : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(user['email'] ?? 'No Email'),
                subtitle: Text('UID: ${user['uid']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PersonalChats(
                            email: user['email'],
                            uid: user['uid'],
                          ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  List<Map<String, dynamic>> name = [
    {'title': 'Add Status'},
    {'title': 'Usman Tariq', 'page': Status1()},
    {'title': 'Adnan', 'page': Status2()},
    {'title': 'Hamza Sheikh', 'page': Stuats3()},
    {'title': 'Saad', 'page': Status4()},
    {'title': 'Yamaan', 'page': Status5()},
    {'title': 'Sidra', 'page': Status6()},
  ];

  List<String> image1 = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyzTWQoCUbRNdiyorem5Qp1zYYhpliR9q0Bw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLA994hpL3PMmq0scCuWOu0LGsjef49dyXVg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdOy8T2bNz8A2GW3lNUsOT8nn73VN8GzTW4g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgi5QWa44hM8fIS26p-ERHujLg24FmLPNNQQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYLYVlJ4_nIB-rwiY2rI1Xz7E7HSS_NmgCzw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzGrJ6vHehJJ31pYnJvWY6_Mz6VyTxW6dxAw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFCJ_MZ2ml6mjMUGIacHKgzqGLLW1_1lo1jA&s',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> pickMedia() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      print('Picked image: ${pickedFile.path}');
      // Upload logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Updates',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: pickMedia,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: name.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (name[index]['page'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => name[index]['page']),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.teal.shade100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(image1[index]),
                          radius: 25,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name[index]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
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
}

class Calls extends StatelessWidget {
  const Calls({super.key});

  final List<Map<String, String>> callHistory = const [
    {
      "name": "Usman Tariq",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLA994hpL3PMmq0scCuWOu0LGsjef49dyXVg&s",
      "time": "Today, 10:30 AM",
    },
    {
      "name": "Adnan",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdOy8T2bNz8A2GW3lNUsOT8nn73VN8GzTW4g&s",
      "time": "Today, 09:15 AM",
    },
    {
      "name": "Hamza Sheikh",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgi5QWa44hM8fIS26p-ERHujLg24FmLPNNQQ&s",
      "time": "Yesterday, 08:00 PM",
    },
    {
      "name": "Saad",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYLYVlJ4_nIB-rwiY2rI1Xz7E7HSS_NmgCzw&s",
      "time": "Yesterday, 01:30 PM",
    },
    {
      "name": "Yamaan",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzGrJ6vHehJJ31pYnJvWY6_Mz6VyTxW6dxAw&s",
      "time": "2 days ago, 06:40 PM",
    },
    {
      "name": "Sidra",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFCJ_MZ2ml6mjMUGIacHKgzqGLLW1_1lo1jA&s",
      "time": "2 days ago, 10:15 AM",
    },
    {
      "name": "Awais",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyzTWQoCUbRNdiyorem5Qp1zYYhpliR9q0Bw&s",
      "time": "3 days ago, 11:45 AM",
    },
    {
      "name": "Zain",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLA994hpL3PMmq0scCuWOu0LGsjef49dyXVg&s",
      "time": "3 days ago, 04:10 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calls",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: callHistory.length,
        itemBuilder: (context, index) {
          final call = callHistory[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(call['image']!),
            ),
            title: Text(
              call['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(call['time']!),
            trailing: const Icon(Icons.call, color: Colors.teal),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => CallScreen(
                        callerName: call['name']!,
                        callerImage: call['image']!,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CallScreen extends StatelessWidget {
  final String callerName;
  final String callerImage;

  const CallScreen({
    super.key,
    required this.callerName,
    required this.callerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 70, backgroundImage: NetworkImage(callerImage)),
          const SizedBox(height: 20),
          Text(
            callerName,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 8),
          const Text(
            'Calling...',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCallButton(Icons.mic, 'Mute'),
              _buildCallButton(Icons.videocam, 'Video'),
              _buildCallButton(Icons.volume_up, 'Speaker'),
            ],
          ),
          const SizedBox(height: 40),
          FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.red,
            child: const Icon(Icons.call_end),
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
