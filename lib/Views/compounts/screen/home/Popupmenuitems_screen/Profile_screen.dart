import 'dart:ffi';
import 'dart:io';
import 'package:chatnow/Views/compounts/screen/auth_module/loginscreen.dart';
import 'package:chatnow/Views/compounts/screen/home/Popupmenuitems_screen/profile_Editing/profile_screen.dart';
import 'package:chatnow/Views/compounts/screen/home/onbording_screen/onbordingscreen1.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showdialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(fontSize: 16),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showdialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

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
          child: Container(
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
          ),
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
                          : AssetImage(''),
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
            Text('M.Rashid', style: TextStyle(fontSize: 20)),
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
                _showdialog1(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Delete Account'),
              onTap: () {
                _showdialog(context);
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
