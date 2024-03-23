import 'package:flutter/material.dart';

InputDecoration textFieldsAddTaskDecoration(String title){
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    hintText: title,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),

  );
}