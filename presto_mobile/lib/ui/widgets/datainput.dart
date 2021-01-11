import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class DataInput extends StatelessWidget {
  final TextEditingController controller;
  final Icon suffixIcon, prefixIcon;
  final String hintText;

  DataInput({
    @required this.controller,
    this.suffixIcon,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 5,
          bottom: 5,
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          cursorColor: color.color1,
          decoration: InputDecoration(
            prefixIcon: prefixIcon ?? null,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: color.color1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorStyle: GoogleFonts.assistant(),
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
            hintMaxLines: 1,
            suffixIcon: suffixIcon ?? null,
          ),
        ),
      ),
    );
  }
}
