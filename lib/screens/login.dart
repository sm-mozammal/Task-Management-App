import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/screens/signup_screen.dart';


import '../network_service/network_requester.dart';
import '../utils/user_data.dart';
import '../widgets/BackgroundImage.dart';
import '../screens/forgetpassscreen.dart';
import '../widgets/reusable_Dan_account.dart';
import '../widgets/reusable_elevated_btn.dart';
import '../widgets/style.dart';
import 'main_home.dart';

//Main Branch
//Main Branch
//Main Branch
//Main Branch

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  TextEditingController emailETcontroller = TextEditingController();
  TextEditingController passETcontroller = TextEditingController();

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
                Text('Get Started With', style: titleTextStyle()),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailETcontroller,
                  decoration: textInputDecoration('Enter your Email'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passETcontroller,
                  obscureText: true,
                  decoration: textInputDecoration('Password'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //button
                ReusableElevatedButton(
                  onTap: () async {
                    if (_form.currentState!.validate()) {
                      final result = await NetworkRequester().postRequest(
                          "https://task.teamrabbil.com/api/v1/login", {
                        "email": emailETcontroller.text,
                        "password": passETcontroller.text
                      });

                      if(result['status']== 'success'){
                        UserData.token = result['token'];
                        UserData.firstName = result['data']['firstName'];
                        UserData.lastName = result['data']['lastName'];
                        UserData.email = result['data']['email'];

                        final shrePref = await SharedPreferences.getInstance();
                        shrePref.setString('email', result['data']['email']);
                        shrePref.setString('firstName', result['data']['firstName']);
                        shrePref.setString('lastName', result['data']['lastName']);
                        shrePref.setString('token', result['token']);
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => const MainHome()),
                                (route) => false);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login Failed, Email or Password wrong, Try Again"))
                        );
                      }
                      print(result);

                    }
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassScreen()));
                        },
                        child: const Text('Forget Password?'))),
                ReusableDanAccount(
                  dhanAccont: 'Don\'t Have an Account',
                  sinupOrIn: 'SignUp?',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
