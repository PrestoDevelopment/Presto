import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class PassInput extends StatefulWidget {
  final TextEditingController controller;
  final Icon prefixIcon;
  final String hintText;

  PassInput({
    @required this.controller,
    this.prefixIcon,
    this.hintText,
  });

  @override
  _PassInputState createState() => _PassInputState();
}

class _PassInputState extends State<PassInput> {
  bool obscureText = true;

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
          controller: widget.controller,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          obscureText: obscureText,
          cursorColor: color.color1,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
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
            hintText: widget.hintText ?? "",
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
            ),
            hintMaxLines: 1,
            suffixIcon: IconButton(
              icon: Icon(
                !obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[800],
                size: 18,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                  print("Changing obscure bool");
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
