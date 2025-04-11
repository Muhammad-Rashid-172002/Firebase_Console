import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class Status4 extends StatefulWidget {
  const Status4({super.key});

  @override
  State<Status4> createState() => _Status4State();
}

class _Status4State extends State<Status4> {
  final StoryController controller = StoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: StoryView(
                storyItems: [
                  StoryItem.text(title: "Hi", backgroundColor: Colors.blue),
                  StoryItem.text(
                    title: "How are you",
                    backgroundColor: Colors.blue,
                  ),
                ],
                controller: controller,
                onComplete: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // **Top User Info Bar**
          Positioned(
            top: 70,
            left: 20,
            right: 10,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdTwRQixFQOTpQQPkvCUYXF_XsqRfovoX-uA&s",
                  ),
                  radius: 22,
                ),
                SizedBox(width: 10),
                Text(
                  "Salman Khan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),

          // **Bottom Reply Box**
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Reply...",
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Send reply functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
