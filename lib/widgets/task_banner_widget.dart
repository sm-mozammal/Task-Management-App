
import 'package:flutter/material.dart';

class TaskbannerWidget extends StatelessWidget {
  TaskbannerWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.date,
  }) : super(key: key);

  final String title,description,date,type;
  final VoidCallback onEditTap, onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.greenAccent.shade100
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            Text(type),
            Text(description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(type),backgroundColor: Colors.green,),
                ButtonBar(
                  children: [
                    IconButton(padding: EdgeInsets.all(0),onPressed: onEditTap, icon: Icon(Icons.edit,color: Colors.blue,)),
                    IconButton(padding: EdgeInsets.all(0),onPressed: onDeleteTap, icon: Icon(Icons.delete,color: Colors.red,)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}