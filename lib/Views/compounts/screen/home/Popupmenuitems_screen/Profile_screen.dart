import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatnow/Views/compounts/screen/auth_module/loginscreen.dart';
import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/profile_Editing/profile_screen.dart';
import 'package:chatnow/Views/compounts/screen/home/onbording_screen/onbordingscreen1.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  await _pickImage(ImageSource.gallery);
                  if (mounted) setState(() {});
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  await _pickImage(ImageSource.camera);
                  if (mounted) setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to log out the user
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // Function to delete the user account permanently
  void _deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.delete();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      } catch (e) {
        print("Error deleting account: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Account deletion failed. Please log in again and try.",
            ),
          ),
        );
      }
    }
  }

  // Show Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Account Confirmation Dialog
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to permanently delete your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteAccount();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      _image != null
                          ? FileImage(_image!) as ImageProvider
                          : AssetImage('assets/images/default_avatar.png'),
                ),
                Positioned(
                  bottom: 7,
                  right: 7,
                  child: InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Icon(Icons.camera_alt, color: Colors.teal, size: 28),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('M. Rashid', style: TextStyle(fontSize: 20)),
            Text('mrashid@gmail.com', style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Logout'),
              onTap: () {
                _showLogoutDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Delete Account'),
              onTap: () {
                _showDeleteDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Version'),
            ),
          ],
        ),
      ),
    );
  }
}
