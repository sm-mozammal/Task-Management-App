import 'package:flutter/material.dart';

import '../network_service/network_requester.dart';
import '../network_service/urls.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';
import 'login.dart';


class SetPassScreen extends StatefulWidget {
  String recoveryMail, recoveryOtp;

   SetPassScreen({required this.recoveryMail,required this.recoveryOtp ,Key? key}) : super(key: key);

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passEtController = TextEditingController();
  final TextEditingController _confirmPassEtController = TextEditingController();

   var progressBar= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Set Password',style: titleTextStyle(),),
              const SizedBox(height: 8,),
              Text('Minimum length of password should be more than 8 letters and non-digits',style: subtitleTextStyle(),),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _passEtController,
                obscureText: true,
                decoration: textInputDecoration('New Password'),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please enter your Password";
                  } else if (value!.length < 8) {
                    return "Password must be atleast 8 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _confirmPassEtController,
                obscureText: true,
                decoration: textInputDecoration('Confirm Password'),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true ){
                    return "Please enter your Password";
                  }else if(value != _passEtController.text){
                    return "Password Not Match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              if(progressBar)
                const Center(child: CircularProgressIndicator(),)
              else
                ReusableElevatedButton(
                  text: 'Confirm', onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      progressBar = true;
                      setState(() {

                      });
                    final response = await NetworkRequester().postRequest(Urls.RecoverResetPass,
                      {
                        "email": widget.recoveryMail,
                        "OTP":widget.recoveryOtp,
                        "password": _confirmPassEtController.text
                      });
                    if(response["status"]=="success"){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pass reset Successfully")));
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
                              (route) => false);
                    }
                  }
                }),
              ReusableDanAccount(dhanAccont: 'Have an Account', sinupOrIn: 'Sign In?', onTap: (){})
            ],
          ),
        ),
      ),
    );
  }
}
