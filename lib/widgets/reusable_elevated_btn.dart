
import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
   ReusableElevatedButton({
    Key? key, required this.onTap,this.text
  }) : super(key: key);

  final VoidCallback onTap;
  String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
          child: text == null ?  Icon(Icons.arrow_circle_right_outlined, color: Colors.white,): Text(text?? ''),
          style: ElevatedButton.styleFrom(
              // backgroundColor: Colors.green,
            primary: Colors.green
          )
      ),
    );
  }
}