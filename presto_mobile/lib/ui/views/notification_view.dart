import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/notification_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:stacked/stacked.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NotificationModel(),
      builder: (context, widget, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: color.color1,
                      radius: 60.0,
                      child: Text('Local Icon',
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                    Column(
                      children: [
                        Text(
                          'Creditworthy Score: 60',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'Mode of payment:',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 4,
                            child: Image.asset('assets/images/paytm.png')),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '1234',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Divider(
                    color: color.color1,
                    thickness: 5.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      'A fellow Bitsian is calling...',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 15,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Yes',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 15,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'No',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
