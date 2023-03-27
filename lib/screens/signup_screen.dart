import 'package:flutter/material.dart';

import '../network_service/network_requester.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _form = GlobalKey<FormState>();
  final TextEditingController _emailEtController = TextEditingController();
  final TextEditingController _firstnameEtController = TextEditingController();
  final TextEditingController _lastnameEtController = TextEditingController();
  final TextEditingController _mobileEtController = TextEditingController();
  final TextEditingController _passEtController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign Up',style: titleTextStyle(),),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _firstnameEtController,
                  decoration: textInputDecoration('First name'),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return "Enter your First Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _lastnameEtController,
                  decoration: textInputDecoration('Last name'),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return "Enter your Last Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _emailEtController,
                  decoration: textInputDecoration('Email'),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return "Enter your Email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _mobileEtController,
                  decoration: textInputDecoration('Mobile'),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return "Enter your Mobile Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _passEtController,
                  decoration: textInputDecoration('Password'),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      return "Enter your Password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                ReusableElevatedButton(onTap: ()async{
                  if(_form.currentState!.validate()){
                   final result = await NetworkRequester().postRequest("https://task.teamrabbil.com/api/v1/registration",{

                      "email":_emailEtController.text,
                      "firstName":_firstnameEtController.text,
                      "lastName":_lastnameEtController.text,
                      "mobile":_mobileEtController.text,
                      "password":_passEtController.text,
                      "photo":""
                    });
                   if(result['status']=="success"){
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text("Registration Successfully "))
                     );
                     _emailEtController.clear();
                     _passEtController.clear();
                     _mobileEtController.clear();
                     _firstnameEtController.clear();
                     _lastnameEtController.clear();
                   }
                  }
                }),
                ReusableDanAccount(dhanAccont: 'Have an Account?', sinupOrIn: 'Sign In', onTap: (){
                  Navigator.pop(context);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
