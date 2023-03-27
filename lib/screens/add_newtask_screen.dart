import 'package:flutter/material.dart';

import '../network_service/network_requester.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_appbar.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descripTEController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(context,isTappable: false),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add New Task',style: titleTextStyle(),),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectTEController,
                  decoration: textInputDecoration("Subject"),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Enter your Task Title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descripTEController,
                  maxLines: 8,
                  decoration: textInputDecoration("Enter your Description"),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Enter your task Description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                if(inProgress)
                  Center(child: CircularProgressIndicator())
                else
                  ReusableElevatedButton(
                  text: 'Add',
                  onTap: ()async{
                    if(_formkey.currentState!.validate()){
                      inProgress = true;
                      setState(() {

                      });
                      final result = await NetworkRequester().postRequest(
                          "https://task.teamrabbil.com/api/v1/createTask",
                          {
                            "title": _subjectTEController.text.trim(),
                            "description":_descripTEController.text.trim(),
                            "status":"New"
                          }

                      );
                      inProgress = false;
                      setState(() {

                      });
                      if(result['status']=="success"){
                        _subjectTEController.clear();
                        _descripTEController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("New Task has been added successfully"))
                        );
                      }


                    }
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
