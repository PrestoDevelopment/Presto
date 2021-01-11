import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class BusyButton extends StatefulWidget {
  final bool busy;
  final String title;
  final Function onPressed;
  final bool enabled;
  const BusyButton(
      {@required this.title,
      this.busy = false,
      @required this.onPressed,
      this.enabled = true});
  @override
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return widget.busy
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: () => widget.onPressed(),
            child: Container(
              decoration: BoxDecoration(
                  color: color.color1,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
