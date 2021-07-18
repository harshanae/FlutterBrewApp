import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('Loading...'),
        centerTitle: true,
      ),
      body: Text("Loading..."),
    );
  }
}
