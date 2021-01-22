import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class PaymentCard extends StatefulWidget {
  final String imagePath;
  final Function callBackToAddInTheOptionInTheList;
  final Function callBackToRemoveInTheOptionInTheList;
  final int index;

  PaymentCard({
    this.imagePath,
    this.callBackToAddInTheOptionInTheList,
    this.callBackToRemoveInTheOptionInTheList,
    this.index,
  });

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Map mapData = {"code": code};
    // String jsonData = json.encode(mapData);

    return GestureDetector(
      onTap: () async {
        setState(() {
          isSelected = !isSelected;
          if (isSelected)
            widget.callBackToAddInTheOptionInTheList(widget.index);
          else
            widget.callBackToRemoveInTheOptionInTheList(widget.index);
        });
        // print("hello");
        // http.Response response = await http.post(
        //     "http://192.168.29.70:3000/firebase/notification/",
        //     headers: {"Content-Type": "application/json"},
        //     body: jsonData);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MapsPage(
        //         lon: longitude,
        //         lat: latitude,
        //       ),
        //     ));
      },
      child: Container(
        height: height / 10,
        width: width / 1.2,
        decoration: BoxDecoration(
          border: Border.all(color: color.color1),
          color: isSelected ? Colors.green : Colors.white,
        ),
        child: Center(
          child: Image.asset(
            widget.imagePath,
            height: height / 10,
            width: width / 2.5,
          ),
        ),
      ),
    );
  }
}
