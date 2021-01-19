import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';
import 'package:file_picker/file_picker.dart';
class TransButton extends StatelessWidget {
  final String tranStatus;

  TransButton({this.tranStatus});

  Future TransButtonTap() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    String displayText;

    switch(tranStatus){
      case "No Transaction" : displayText = "Confirm Sent!";
      break;
      case "Lender Sent Money" : displayText = "Confirm Receive";
      break;
      case "Borrower Recieved money" : displayText = "Payback Now!";
      break;
      case "Borrower sent money" : displayText = "Confirm Payback";
      break;
      default : displayText = null;

    }

    if(displayText!=null){
      return GestureDetector(
        child: Container(
          height: height / 17,
          width: width / 4,
          color: color1,
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        onTap: TransButtonTap,
      );
    }else{
      return null;
    }

  }
}
