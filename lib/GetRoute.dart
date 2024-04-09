import 'package:flutter/material.dart';

class GetRoute extends StatefulWidget {
  const GetRoute({Key? key}) : super(key: key);

  @override
  _GetRouteState createState() => _GetRouteState();
}

class _GetRouteState extends State<GetRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title '),
      ),
    );
  }
}
