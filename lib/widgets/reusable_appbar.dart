import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../screens/login.dart';
import '../screens/update_profile_screen.dart';
import '../utils/user_data.dart';

AppBar ReusableAppBar(context,{bool isTappable = true}) {
  return AppBar(
    backgroundColor: Colors.green,
    title: ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: (){
        if(isTappable == false){
          return ;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
      },
      leading:  CircleAvatar(
        backgroundColor: Colors.green.shade500,
        child: Icon(Icons.person),
      ),
      title: Text("${UserData.firstName ?? ''} ${UserData.firstName ?? ''}"),
      subtitle:  Text(UserData.email?? ""),
    ),
    actions: [
      IconButton(onPressed: ()async{
        final sharPref = await SharedPreferences.getInstance();
        sharPref.clear();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
      }, icon: Icon(Icons.logout))
    ],
  );
}