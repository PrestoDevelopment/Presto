import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class AmountButton extends StatelessWidget {
  final String text;
  final Function onTap;
  AmountButton({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height / 20,
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: color.color1),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
