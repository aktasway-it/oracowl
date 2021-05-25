import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading();

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: () => { Navigator.pushNamed(context, '/home')},
            child: Text('Load!'),
          ),
        )
      )
    );
  }
}
