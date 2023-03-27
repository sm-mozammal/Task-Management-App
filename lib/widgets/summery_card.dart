import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {

  int counterR;
  String title;

   SummeryCard(this.counterR,this.title, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(4),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Text('$counterR',style: TextStyle(fontSize: 18),),
              FittedBox(child: Text('$title Task'))
            ],
          ),
        ),
      ),
    );
  }
}