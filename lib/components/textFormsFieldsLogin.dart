import 'package:flutter/material.dart';

InputDecoration textFormsFieldsLogin(String title, Icon icon){
  return InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),

      prefixIcon: icon,
      prefixIconColor: Colors.black,
      hintText: title,
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(2)
  );
}