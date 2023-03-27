import 'package:flutter/material.dart';

import '../widgets/task_banner_widget.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context,index){
        return TaskbannerWidget(
          title: 'This is title',
          date: '13 january 2023',
          description: 'this is description',
          type: 'Cancelled',
          onEditTap: (){},
          onDeleteTap: (){},
        );
      },
    );
  }
}
