
import 'package:flutter/material.dart';

TextStyle titleTextStyle(){
  return const TextStyle(
      fontSize: 35,
      color: Colors.black,
      fontWeight: FontWeight.bold
  );
}
TextStyle subtitleTextStyle(){
  return  TextStyle(
    fontSize: 13,
    color: Colors.grey.shade700
  );
}

InputDecoration textInputDecoration(hinText){
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hinText,
      border: const OutlineInputBorder()
  );
}
