import 'package:flutter/material.dart';

InputDecoration textFieldsDetailsDecoration(String title){
  return InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    hintText: title,
  );
}