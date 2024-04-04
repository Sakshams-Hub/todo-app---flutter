import 'package:flutter/material.dart';

class MyPass extends StatefulWidget {
  const MyPass({super.key});

  @override
  State<MyPass> createState() => _MyPassState();
}

class _MyPassState extends State<MyPass> {
  final String routeName = '/Pass';

  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text("Pass Data")),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
                defaultColumnWidth: FixedColumnWidth(50),
                border: TableBorder.all(),
                children: const [
                  TableRow(children: [
                    Column(
                      children: [
                        Text('data'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('data'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('data'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('data'),
                      ],
                    )
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('Flutter')]),
                    Column(children: [Text('5*')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('Flutter')]),
                    Column(children: [Text('5*')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('Flutter')]),
                    Column(children: [Text('5*')]),
                    Column(children: [Text('5*')]),
                  ]),
                  TableRow(children: [
                    Column(children: [Text('Javatpoint')]),
                    Column(children: [Text('Flutter')]),
                    Column(children: [Text('5*')]),
                    Column(children: [Text('5*')]),
                  ]),
                ]),
          ),
        ));
  }
}
