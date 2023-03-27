import 'package:flutter/material.dart';


import '../models/new_task_model.dart';
import '../network_service/network_requester.dart';
import '../network_service/urls.dart';
import '../widgets/summery_card.dart';
import '../widgets/task_banner_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  NewTaskModel? _newTaskModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNewTaskFromApi();
    });


  }

  Future<void> getNewTaskFromApi() async {
    final response = await NetworkRequester().getRequest(Urls.newTaskUrl);
    if (response['status'] == "success") {
      _newTaskModel = NewTaskModel.fromJson(response);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SummeryCard(23, "New"),
            SummeryCard(23, "Completed"),
            SummeryCard(23, "Cancelled"),
            SummeryCard(23, "In Progress"),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
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
                var reverselist = _newTaskModel!.data!.reversed.toList();
                final task = reverselist[index];
                return TaskbannerWidget(
                  title: task.title ?? "",
                  date: task.createdDate ?? "",
                  description: task.description ?? "",
                  type: task.status ?? 'New',
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
