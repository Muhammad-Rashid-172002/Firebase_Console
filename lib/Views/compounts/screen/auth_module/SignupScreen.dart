import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(Icons.arrow_back_ios),
        title: Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 150,
              child: Image.asset('assets/images/Capture.PNG'),
            ),
            SizedBox(height: 10),
            Text(
              'Sign up now to ChatNow',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Please enter your email and password to sign up',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Your Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Your Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signupscreen()),
                    );
                  },
                  child: Text('Sign in'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 10,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/facebook.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
