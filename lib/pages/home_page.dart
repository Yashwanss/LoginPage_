import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueGrey,
        elevation: 1,
        surfaceTintColor: const Color.fromARGB(53, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Expanded(
          child: Text(
            "Logged in as: ${user.email!}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
