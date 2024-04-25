import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class TextFormFieldCustom extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? msgError;
  final int? maxLines;



  TextFormFieldCustom({required this.title, required this.controller, required this.msgError , required this.maxLines});

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.msgError;
        }
        return null;
      },
      maxLines: widget.maxLines,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      // ],
      decoration: InputDecoration(

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        hintText: widget.title,
      ),
      keyboardType: TextInputType.text,
    );
  }
}


