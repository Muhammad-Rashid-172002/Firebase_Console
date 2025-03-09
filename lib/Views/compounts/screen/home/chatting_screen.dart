import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/Profile_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'ChatNow',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "New Group") {
                Navigator.pushNamed(context, '/newgroup');
              } else if (value == "Linked Devices") {
                Navigator.pushNamed(context, '/linkeddevices');
              } else if (value == "Profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              } else {
                print('Selected $value');
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: "New Group", child: Text('New Group')),
                  PopupMenuItem(
                    value: "Linked Devices",
                    child: Text('Linked Devices'),
                  ),
                  PopupMenuItem(value: "Profile", child: Text('Profile')),
                ],
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
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

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text('this is call screen')]));
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('this is status screen')]);
  }
}

class Chatscreen extends StatelessWidget {
  const Chatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('this is chat screen')]);
  }
}
