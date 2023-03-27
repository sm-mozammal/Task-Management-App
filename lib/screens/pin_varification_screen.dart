import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../network_service/network_requester.dart';
import '../network_service/urls.dart';
import '../widgets/BackgroundImage.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';
import '../screens/setpass_screen.dart';

class PinVarificationScreen extends StatefulWidget {
  String recoveryEmail;
   PinVarificationScreen({Key? key,required this.recoveryEmail}) : super(key: key);

  @override
  State<PinVarificationScreen> createState() => _PinVarificationScreenState();
}

class _PinVarificationScreenState extends State<PinVarificationScreen> {

  TextEditingController pinTextETtController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pin Varification',style: titleTextStyle(),),
              const SizedBox(height: 8,),
              Text('A 6 digits pin has been sent to your email',style: subtitleTextStyle(),),
              const SizedBox(height: 20,),
              PinCodeTextField(
                key: _formkey,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  activeColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.grey.shade500,
                  inactiveColor: Colors.grey.shade500
                ),
                animationDuration: Duration(milliseconds: 300),
                cursorColor: Colors.black,
                enableActiveFill: true,
                controller: pinTextETtController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);

                },
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Enter your Email Address";
                  }
                  return null;
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),
              const SizedBox(height: 20,),
              ReusableElevatedButton(
                text: 'Verify',
                onTap: ()async{
                    final recoveryEmail = widget.recoveryEmail;
                    final pin = pinTextETtController.text;
                    final response = await NetworkRequester().getRequest(Urls.RecoverVerifyOTP+recoveryEmail+"/"+pin);
                    if(response["status"]=="success"){
                      pinTextETtController.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SetPassScreen(
                        recoveryMail: recoveryEmail,
                        recoveryOtp: pin,
                      )));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Wrong OTP please Check '))
                      );
                    }


                },
              ),
              const SizedBox(height: 30,),
              ReusableDanAccount(dhanAccont: 'Have an account',sinupOrIn: 'Sign In',onTap: (){

              },)
            ],
          ),
        )
      ),
    );
  }
}
