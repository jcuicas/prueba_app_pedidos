import 'package:flutter/material.dart';

class MyButtonDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const MyButtonDrawer({
    super.key,
    this.scaffoldKey,
  });

  @override
  State<MyButtonDrawer> createState() => _MyButtonDrawerState();
}

class _MyButtonDrawerState extends State<MyButtonDrawer> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.scaffoldKey!.currentState!.openDrawer();
      },
      icon: Icon(
        Icons.menu,
        color: Color(0xffffffff),
      ),
    );
  }
}
