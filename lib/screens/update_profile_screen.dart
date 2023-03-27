import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_appbar.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  XFile? photoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(context,isTappable:false),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Update Profile',style: titleTextStyle(),),
              const SizedBox(height: 20,),
              InkWell(
                onTap: ()async{
                 final imagePicker =  ImagePicker();
                 final result = await imagePicker.pickImage(source: ImageSource.gallery);
                 if(result != null){
                   photoFile = result;
                   setState(() {

                   });
                 }
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Photo',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      if(photoFile != null)
                        Image.file(File(photoFile?.path ?? ""),width: 30,height: 30),
                      Expanded(child: Text(photoFile?.name ?? "",maxLines: 2,))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: textInputDecoration('First name'),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: textInputDecoration('Last name'),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: textInputDecoration('Email'),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: textInputDecoration('Mobile'),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: textInputDecoration('Password name'),
              ),
              const SizedBox(height: 16,),
              ReusableElevatedButton(onTap: (){}),
              ReusableDanAccount(dhanAccont: 'Have an Account?', sinupOrIn: 'Sign In', onTap: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
