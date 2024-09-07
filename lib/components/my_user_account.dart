import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  final String userEmail;
  final String fullName;

  const UserAccount({
    super.key,
    required this.userEmail,
    required this.fullName,
  });

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xff000000),
        border: Border(
          bottom: BorderSide(
            color: Color(0xffec1c24),
            width: 3.0,
          ),
        ),
      ),
      accountName: Text(widget.fullName),
      accountEmail: Text(widget.userEmail),
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.supervised_user_circle_rounded,
          size: 72.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
