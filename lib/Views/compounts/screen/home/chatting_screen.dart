import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/Profile_screen.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat1.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat2.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat3.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat4.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat5.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat6.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat7.dart';
import 'package:chatnow/Views/compounts/screen/home/personal_chatting/chat8.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status1.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status2.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status3.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status4.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status5.dart';
import 'package:chatnow/Views/compounts/screen/home/status/status6.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Calls',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Clear call log") {
                  Navigator.pushNamed(context, '/clearcalllog');
                } else if (value == "Settings") {
                  Navigator.pushNamed(context, '/settings');
                } else if (value == "Help") {
                  Navigator.pushNamed(context, '/help');
                } else {
                  print('Selected $value');
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: "Clear call log",
                      child: Text('Clear call log'),
                    ),
                    PopupMenuItem(value: "Settings", child: Text('Settings')),
                    PopupMenuItem(value: "Help", child: Text('Help')),
                  ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Row(
            children: [
              Text(
                'Favorites',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                ),
                child: Icon(Icons.favorite, color: Colors.white),
              ),
              SizedBox(width: 10),
              Text(
                'Add favorite',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(height: 200),
        Center(child: Text('To start contacts who have')),
        Text('WhatsApp, tap at the'),
        Text('at the bottom of your\n       screen.'),
      ],
    );
  }
}

class StatusScreen extends StatelessWidget {
  StatusScreen({super.key});
  List name = [
    {'title': 'Add Status'},
    {'title': 'Salman Khan', 'page': Status1()},
    {'title': 'Adnan', 'page': Status2()},
    {'title': 'king', 'page': Status3()},
    {'title': 'Saad', 'page': Status4()},
    {'title': 'Yamaan', 'page': Status5()},
    {'title': 'Sidra', 'page': Status6()},
  ];
  List images = [
    'assets/images/1 (1).jpeg',
    'assets/images/1 (1).jpg',
    'assets/images/1 (2).jpeg',
    'assets/images/1 (2).jpg',
    'assets/images/1 (3).jpeg',
    'assets/images/1 (4).jpeg',
    'assets/images/2 (1).jpg',
  ];
  List image1 = [
    'assets/images/1 (1).jpeg',
    ' assets/images/1 (1).jpg',
    ' assets/images/1 (2).jpeg',
    ' assets/images/1 (2).jpg',
    ' assets/images/1 (3).jpeg',
    ' assets/images/1 (4).jpeg',
    ' assets/images/2 (1).jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.teal,
              title: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (image != null) {
                      print("Image Path: ${image.path}");
                      // You can set the image to display it in your UI
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Privacy") {
                      Navigator.pushNamed(context, '/privacy');
                    } else if (value == "Settings") {
                      Navigator.pushNamed(context, '/settings');
                    } else if (value == "Help") {
                      Navigator.pushNamed(context, '/help');
                    } else {
                      print('Selected $value');
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(value: "Privacy", child: Text('Privacy')),
                        PopupMenuItem(
                          value: "Settings",
                          child: Text('Settings'),
                        ),
                        PopupMenuItem(value: "Help", child: Text('Help')),
                      ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: name.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        if (name[index]['page'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => name[index]['page'],
                            ),
                          );
                        } else {
                          print("No page assigned for this item.");
                        }
                      },
                      child: Container(
                        height: 250,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.tealAccent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ClipRRect(
                                  child: Image.asset(
                                    image1[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text(name[index]['title'])],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                children: [
                  Text(
                    'Channels',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  SizedBox(width: 180),
                  Text(
                    'Explore  >',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Stay updated on topics that matter to you. Find\nchannels to follow bellow',
            ),
          ],
        ),
      ),
    );
  }
}

class Chatscreen extends StatefulWidget {
  Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final List<Map<String, dynamic>> contacts = [
    {
      'title': 'John Doe',
      'image': 'assets/images/1 (1).jpeg',
      'page': Chat1(),
      'lastMessage': 'Hey! How are you?',
    },
    {
      'title': 'Abrar Khan',
      'image': 'assets/images/1 (1).jpg',
      'page': Chat2(),
      'lastMessage': 'See you tomorrow!',
    },
    {
      'title': 'Salman Khan',
      'image': 'assets/images/1 (2).jpeg',
      'page': Chat3(),
      'lastMessage': 'Thanks for your help!',
    },
    {
      'title': 'Akram Shah',
      'image': 'assets/images/1 (2).jpg',
      'page': Chat4(),
      'lastMessage': 'I will call you later.',
    },
    {
      'title': 'Bilal Ahmad',
      'image': 'assets/images/1 (3).jpeg',
      'page': Chat5(),
      'lastMessage': 'Did you complete the task?',
    },
    {
      'title': 'Abbas Afridi',
      'image': 'assets/images/1 (4).jpeg',
      'page': Chat6(),
      'lastMessage': 'Let’s meet at 5 PM.',
    },
    {
      'title': 'M.Yamaan',
      'image': 'assets/images/2 (1).jpg',
      'page': Chat7(),
      'lastMessage': 'Happy birthday, bro!',
    },
    {
      'title': 'M.Rashid',
      'image': 'assets/images/2 (2).jpg',
      'page': Chat8(),
      'lastMessage': 'Where are you now?',
    },
  ];

  final List<String> times = [
    '2:00 AM',
    '4:30 PM',
    '7:10 AM',
    '9:22 AM',
    '9:00 AM',
    '4:33 PM',
    '7:45 AM',
    '10:00 AM',
  ];

  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    filteredContacts = List.from(contacts); // ✅ Keep original messages
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredContacts = List.from(contacts);
      } else {
        filteredContacts =
            contacts
                .where(
                  (contact) => contact['title'].toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'Chats',
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
                      PopupMenuItem(
                        value: "New Group",
                        child: Text('New Group'),
                      ),
                      PopupMenuItem(
                        value: "Linked Devices",
                        child: Text('Linked Devices'),
                      ),
                      PopupMenuItem(value: "Profile", child: Text('Profile')),
                    ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: _filterContacts, // Call filter function on typing
              decoration: InputDecoration(
                filled: true,
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      filteredContacts[index]['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    filteredContacts[index]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    filteredContacts[index]['lastMessage'] ??
                        'No message available',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    times[index % times.length],
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    if (filteredContacts[index]['page'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => filteredContacts[index]['page'],
                        ),
                      );
                    }
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
