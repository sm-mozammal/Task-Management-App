import 'package:flutter/material.dart';

class ReusableDanAccount extends StatelessWidget {
  ReusableDanAccount({
    required this.dhanAccont,
    required this.sinupOrIn,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  String dhanAccont,sinupOrIn;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(dhanAccont),
        TextButton(onPressed: onTap, child: Text(sinupOrIn))
      ],
    );
  }
}