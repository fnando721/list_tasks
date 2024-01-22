import 'package:flutter/material.dart';

InputDecoration textFieldsDetailsDecoration(){
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: Colors.black
        )
    ),
    hintText: 'Nome da Tarefa',
  );
}