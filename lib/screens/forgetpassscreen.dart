

import 'package:flutter/material.dart';
import 'package:task_management_app/screens/pin_varification_screen.dart';


import '../network_service/network_requester.dart';
import '../network_service/urls.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';

class ForgotPassScreen extends StatelessWidget {
   ForgotPassScreen({Key? key}) : super(key: key);
  TextEditingController emailEtController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child:Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Email Address',style: titleTextStyle(),),
              const SizedBox(height: 8,),
              Text('Your Email Address',style: subtitleTextStyle(),),
              const SizedBox(height: 20,),
              TextFormField(
                controller: emailEtController,
                decoration:  textInputDecoration('email'),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Enter your Email Address";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20,),

              ReusableElevatedButton(onTap: () async{
                if(_formkey.currentState!.validate()){
                  final recoveryEmail = emailEtController.text;
                  final response = await NetworkRequester().getRequest(Urls.recoverEmailUrl+recoveryEmail);
                  if(response["status"]=="success"){
                    emailEtController.clear();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PinVarificationScreen(recoveryEmail: recoveryEmail,)));
                  }
                }

              },),
              const SizedBox(height: 32,),
              ReusableDanAccount(dhanAccont: 'Have an Account',sinupOrIn: 'Sign In',onTap: (){
                Navigator.pop(context);
              },)
            ],
          ),
        )
      ),
    );
  }
}




