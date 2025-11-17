import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/presentation/provider/auth_controller.dart';
import 'package:test/presentation/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  void showEditBottomSheet(BuildContext context, AuthController auth) {
    final nameController = TextEditingController(
      text: auth.currentUser?.name ?? '',
    );
    final emailController = TextEditingController(
      text: auth.currentUser?.email ?? '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: nameController,

                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Enter Email ';
                      } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(v)) {
                        return 'Enter valid mail';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        auth.updateProfile(
                          nameController.text,
                          emailController.text,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      auth.currentUser?.photoUrl ??
                      'https://cdn-icons-png.flaticon.com/512/6522/6522516.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Name & Email as ListTile
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Name"),
              subtitle: Text(auth.currentUser?.name ?? 'User'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text(auth.currentUser?.email ?? 'user@example.com'),
            ),

            SizedBox(height: 20),

            // Buttons: Logout & Edit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logout Button
                ElevatedButton.icon(
                  onPressed: () async {
                    await auth.logout();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Logging out..."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      await Future.delayed(Duration(seconds: 2));
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    }
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                ),

                // Edit Button
                ElevatedButton.icon(
                  onPressed: () => showEditBottomSheet(context, auth),
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
