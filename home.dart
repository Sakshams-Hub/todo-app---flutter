import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  final String routeName = '/Fourth';
  // final data = "Hello World";
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final data = "Hello World";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List")),
        body: ListView.builder(
            itemCount: 40,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.home),
                title: (Text("List${index}")),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed('/Grid');
                    // Navigator.pushNamed(context, '/Second');
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              );
            }));
  }
}
