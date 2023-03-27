import 'package:flutter/material.dart';

import '../models/new_task_model.dart';
import '../network_service/network_requester.dart';
import '../network_service/urls.dart';
import '../widgets/task_banner_widget.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreen();
}

class _CompletedTaskScreen extends State<CompletedTaskScreen> {
  NewTaskModel? _newTaskModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNewTaskFromApi();
    });
  }

  Future<void> getNewTaskFromApi() async {
    final response = await NetworkRequester().getRequest(Urls.completedTaskUrl);
    if (response['status'] == "success") {
      _newTaskModel = NewTaskModel.fromJson(response);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      if (_newTaskModel == null)
        Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      else
        Expanded(
          child: ListView.builder(
            itemCount: _newTaskModel?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final task = _newTaskModel!.data![index];
              return TaskbannerWidget(
                title: task.title ?? "",
                date: task.createdDate ?? "",
                description: task.description ?? "",
                type: task.status ?? 'Completed',
                onEditTap: () {},
                onDeleteTap: () {},
              );
            },
          ),
        )
      ],
    );
  }
}
