import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DateTimePickerCustom extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const DateTimePickerCustom({super.key, required this.title, required this.controller });

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      decoration:InputDecoration(

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        hintText: title,
      ),
      firstDate:
      DateTime.now().subtract(Duration(days: 365 * 10)),
      lastDate: DateTime.now().add(Duration(days: 365 * 10)),
      type: DateTimePickerType.date,
      controller: controller,
      validator: (value) => value == null? 'Adicione a Data': null,
      onChanged: (date){

      },
      dateMask: 'dd/MM/yyyy',
//locale: Locale('pt', 'BR'),
    );;
  }
}




