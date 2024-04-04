import 'package:flutter/material.dart';

class MyUser extends StatefulWidget {
  const MyUser({super.key});

  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushNamed('/Form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
