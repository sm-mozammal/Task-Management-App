import 'package:flutter/material.dart';

import '../widgets/task_banner_widget.dart';

class InprogressTaskScreeen extends StatefulWidget {
  const InprogressTaskScreeen({Key? key}) : super(key: key);

  @override
  State<InprogressTaskScreeen> createState() => _InprogressTaskScreeenState();
}

class _InprogressTaskScreeenState extends State<InprogressTaskScreeen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context,index){
        return TaskbannerWidget(
          title: 'This is title',
          date: '13 january 2023',
          description: 'this is description',
          type: 'In Progress',
          onEditTap: (){},
          onDeleteTap: (){},
        );
      },
    );
  }
}
