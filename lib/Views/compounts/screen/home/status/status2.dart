import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class Status2 extends StatefulWidget {
  const Status2({super.key});

  @override
  State<Status2> createState() => _Status2State();
}

class _Status2State extends State<Status2> {
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
                  StoryItem.pageImage(
                    url:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqvFdpefJi2hOnOjNhVL78frJ-clk2_NqW8Q&s", // sample image
                    controller: controller,
                    caption: Text("Enjoying the view "),
                  ),
                  StoryItem.pageVideo(
                    "https://www.w3schools.com/html/mov_bbb.mp4", // sample video
                    controller: controller,
                    caption: Text("Enjoying the view"),
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
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdOy8T2bNz8A2GW3lNUsOT8nn73VN8GzTW4g&s",
                  ),
                  radius: 22,
                ),
                SizedBox(width: 10),
                Text(
                  "Adnan",
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
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Reply...",
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
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
